/*
-----------------------------------------------------------------------------
File Name: API_OPENAI.swift
Description: Configures the request to OpenAI API and manages interactions
             with the API, including message sending and response handling.
-----------------------------------------------------------------------------
Creation Date: 10/21/23
-----------------------------------------------------------------------------
Author: Arryan Bhatnagar
Project: Cosmofy 4th Edition
-----------------------------------------------------------------------------
*/
 
 
/* MARK: imports */
import Foundation
import CryptoKit

// Flag indicating whether AES decryption is complete
var AES_Complete: Bool = false

/* MARK: class InteractingViewModel
   ViewModel for interacting with the OpenAI API
 */

class InteractingViewModel: ObservableObject {
    
    @Published var isInteractingWithChatGPT = false
    @Published var messages: [MessageRow] = []
    @Published var inputMessage: String = ""
    
    private let api: API
    
    // Initialize the view model with an API instance
    init(api: API) {
        self.api = api
        
        messages.append(MessageRow(
            isInteractingWithChatGPT: false,
            sendImage: "openai",
            sendText: "Greetings from Swift! I can provide you with in-depth knowledge and insights about space like never before.",
            responseImage: "",
            responseText: nil,
            responseError: nil
        ))
    }
    
    // Handles the send button tap event by sending the input message.
    @MainActor
    func sendTapped() async {
        let text = inputMessage
        inputMessage = ""
        await send(text: text)
    }
    
    // Retries sending a previously sent message.
    // Parameter message: The message to be retried.
    @MainActor
    func retry(message: MessageRow) async {
        guard let index = messages.firstIndex(where: {$0.id == message.id}) else {
            return
        }
        
        self.messages.remove(at: index)
        await send(text: message.sendText)
    }
    
    // Sends a text message and updates the message list with the response.
    // Parameter text: The text to be sent.
    @MainActor
    func send(text: String) async {
        isInteractingWithChatGPT = true
        var streamText = ""
        var messageRow = MessageRow(
            isInteractingWithChatGPT: true, 
            sendImage: "user",
            sendText: text,
            responseImage: "swift",
            responseText: streamText,
            responseError: nil
        )
        
        self.messages.append(messageRow)
        
        do {
            let stream = try await api.sendMessageStream(text: text)
            for try await text in stream {
                streamText += text
                messageRow.responseText = streamText.trimmingCharacters(in: .whitespacesAndNewlines)
                self.messages[self.messages.count - 1] = messageRow
            }
        } catch {
            messageRow.responseError = error.localizedDescription
        }
        
        messageRow.isInteractingWithChatGPT = false
        self.messages[self.messages.count - 1] = messageRow
        isInteractingWithChatGPT = false;
    }
}

/* MARK: class API
   API client for communicating with OpenAI.
 */
class API: @unchecked Sendable {
        
    private let systemMessage: Message
    private let temperature: Double
    private let model: String
    
    private let aesKey: SymmetricKey = SymmetricKey(data: Data(base64Encoded: Bundle.main.infoDictionary?["API_KEY_DEBUG"] as! String)!)
    
    private var apiKey: String?
    private var historyList = [Message]()
    private let urlSession = URLSession.shared
    
    private var urlRequest: URLRequest {
        let url = URL(string: "http://api.arryan.xyz:8002/api/providers/openai/v1/chat/completions" )!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        headers.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }
        return urlRequest
    }
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df
    }()
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    private var headers: [String: String] {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey ?? "")"
        ]
    }
    
    init(model: String = "gpt-3.5-turbo", systemPrompt: String = "You are a helpful assistant who will answer space/astronomy questions. Your name is Swift. You may answer any other questions. You are in an app called Cosmofy.", temperature: Double = 0.65) {
        self.model = model
        self.systemMessage = .init(role: "system", content: systemPrompt)
        self.temperature = temperature

        fetchApiKey { [weak self] decryptedApiKey in
            self?.apiKey = decryptedApiKey
            print("Swift: AES Complete, Successfully Authenticated")
            AES_Complete = true
        }
    }
    
    // Fetches and decrypts the API key.
    // Parameter completion: Closure to be called with the decrypted API key.
    private func fetchApiKey(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.arryan.xyz:6969/get-api-key") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching API key: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                   let encryptedData = json["encryptedData"],
                   let iv = json["iv"],
                   let authTag = json["authTag"] {
                    let decryptedApiKey = self.decrypt(encryptedData: encryptedData, iv: iv, authTag: authTag)
                    completion(decryptedApiKey)
                } else {
                    print("Invalid response format")
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Decrypts the provided data using AES encryption.
    // Parameters:
    // - encryptedData: Base64 encoded encrypted data.
    // - iv: Base64 encoded initialization vector.
    // - authTag: Base64 encoded authentication tag.
    // Returns: Decrypted string or nil if decryption fails.
    private func decrypt(encryptedData: String, iv: String, authTag: String) -> String? {
        guard let encryptedData = Data(base64Encoded: encryptedData),
              let iv = Data(base64Encoded: iv),
              let authTag = Data(base64Encoded: authTag) else {
            print("Invalid base64 string")
            return nil
        }
        
        do {
            let sealedBox = try AES.GCM.SealedBox(nonce: AES.GCM.Nonce(data: iv), ciphertext: encryptedData, tag: authTag)
            let decryptedData = try AES.GCM.open(sealedBox, using: aesKey)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func generateMessages(from text: String) -> [Message] {
        var messages = [systemMessage] + historyList + [Message(role: "user", content: text)]
        
        if messages.contentCount > (16000 * 4) {
            _ = historyList.removeFirst()
            messages = generateMessages(from: text)
        }
        return messages
        
    }
    
    func sendMessageStream(text: String) async throws -> AsyncThrowingStream<String, Error> {
        var urlRequest = self.urlRequest
        urlRequest.httpBody = try jsonBody(text: text)
        
        let (result, response) = try await urlSession.bytes(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw "Invalid Response"
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            
            var errorText = ""
            for try await line in result.lines {
                errorText += line
            }
            
            if let data = errorText.data(using: .utf8), let errorResponse = try? jsonDecoder.decode(ErrorRootResponse.self, from: data).error {
                errorText = "\n\(errorResponse.message)"
            }
            throw "Bad Response: \(httpResponse.statusCode), \(errorText)"

        }
        
        return AsyncThrowingStream<String, Error> {
            continuation in Task(priority: .userInitiated) { [weak self] in
                guard let self else { return }
                do {
                    var responseText = ""
                    var accumulatedText = ""
                    for try await line in result.lines {
                        if line.hasPrefix("data: "),
                           let data = line.dropFirst(6).data(using: .utf8),
                           let response = try? self.jsonDecoder.decode(StreamCompletionResponse.self, from: data),
                           let text = response.choices.first?.delta.content {
                            /* Haptics.shared.impact(for: .light)  */
                            responseText += text
                            continuation.yield(text)
                            /* Slows down each token by 2 ns
                            try await Task.sleep(nanoseconds: 2 * 10000000) */
                        }
                    }
                    self.appendToHistoryList(userText: text, responseText: responseText)
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    func sendMessage(_ text: String) async throws -> String {
        var urlRequest = self.urlRequest
        urlRequest.httpBody = try jsonBody(text: text, stream: false)
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw "Invalid Response"
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            var error = "Bad Response: \(httpResponse.statusCode)"
            if let errorResponse = try? jsonDecoder.decode(ErrorRootResponse.self, from: data).error {
                error.append("\n\(errorResponse.message)")
            }
            throw error
        }
        
        do {
            let completionResponse = try self.jsonDecoder.decode(CompletionResponse.self, from: data)
            let responseText = completionResponse.choices.first?.message.content ?? ""
            self.appendToHistoryList(userText: text, responseText: responseText)
            return responseText
        } catch {
            throw error
        }
    }
    
    private func jsonBody(text: String, stream: Bool = true) throws -> Data {
        if (text.count > 40000) {
            throw "Long Response: Max character limit of 40000"
        }
        
        let request = Request(model: model, temperature: temperature, messages: generateMessages(from: text), stream: stream)
        return try JSONEncoder().encode(request)
    }
    
    private func appendToHistoryList(userText: String, responseText: String) {
        self.historyList.append(.init(role: "user", content: userText))
        self.historyList.append(.init(role: "assistant", content: responseText))
    }
}

/* MARK: extension String */
extension String: CustomNSError {
    public var errorUserInfo: [String : Any] {
        [
            NSLocalizedDescriptionKey: self
        ]
    }
}

/* MARK: extension Data */
extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        var byteLiteral = ""
        for (index, character) in hexString.enumerated() {
            byteLiteral.append(character)
            if index % 2 != 0 {
                guard let byte = UInt8(byteLiteral, radix: 16) else { return nil }
                data.append(byte)
                byteLiteral = ""
            }
        }
        self = data
    }
}

