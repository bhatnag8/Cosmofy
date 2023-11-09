//  ========================================
//  API.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 10/21/23.
//  Abstract: Configures the request to OpenAI API.
//  ========================================

import Foundation

class API: @unchecked Sendable {
        
    private let systemMessage: Message
    private let temperature: Double
    private let model: String
    
    private let apiKey = Bundle.main.infoDictionary?["API_KEY_DEBUG"] as! String
    private var historyList = [Message]()
    private let urlSession = URLSession.shared
    private var urlRequest: URLRequest {
        let url = URL(string: "https://api.openai.com/v1/chat/completions" )!
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
            "Authorization": "Bearer \(apiKey)"
        ]
    }
    
    init(model: String = "gpt-3.5-turbo-0301", systemPrompt: String = "You are a helpful assistant who will answer space/astronomy questions. Your name is Swift. You don't have information about other stuff to give advice so try not to do that. However, it's okay to give out the other information from time to time.", temperature: Double = 0.6) {
        self.model = model
        self.systemMessage = .init(role: "system", content: systemPrompt)
        self.temperature = temperature
    }
    
    private func generateMessages(from text: String) -> [Message] {
        var messages = [systemMessage] + historyList + [Message(role: "user", content: text)]
        
        if messages.contentCount > (4000 * 4) {
            _ = historyList.dropFirst()
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
                    for try await line in result.lines {
                        if line.hasPrefix("data: "),
                           let data = line.dropFirst(6).data(using: .utf8),
                           let response = try? self.jsonDecoder.decode(StreamCompletionResponse.self, from: data),
                           let text = response.choices.first?.delta.content {
                            Haptics.shared.impact(for: .heavy)
                            responseText += text
                            continuation.yield(text)
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
        print(text.count)
        if (text.count > 10000) {
            throw "Long Response: Max char limit of 10000"
        }
        
        
        let request = Request(model: model, temperature: temperature, messages: generateMessages(from: text), stream: stream)
        return try JSONEncoder().encode(request)
    }
    
    private func appendToHistoryList(userText: String, responseText: String) {
        self.historyList.append(.init(role: "user", content: userText))
        self.historyList.append(.init(role: "assistant", content: responseText))

    }
}

extension String: CustomNSError {
    public var errorUserInfo: [String : Any] {
        [
            NSLocalizedDescriptionKey: self
        ]
    }
}
