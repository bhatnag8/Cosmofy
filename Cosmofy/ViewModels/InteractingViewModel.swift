//  ========================================
//  ViewModel.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 10/24/23.
//  Abstract: How the UI initializes the API.
//  ========================================

import Foundation
import SwiftUI

class InteractingViewModel: ObservableObject {
    
    @Published var isInteractingWithChatGPT = false
    @Published var messages: [MessageRow] = []
    @Published var inputMessage: String = ""
    
    private let api: API
    //  🌌 🚀 🌠 🏔️ 🌟
    init(api: API) {
        self.api = api
        messages.append(MessageRow(isInteractingWithChatGPT: false,
                                            sendImage: "openai",
                                            sendText: "Greetings from Swift! I can provide you with in-depth knowledge and insights about space like never before.",
                                            responseImage: "",
                                            responseText: nil,
                                            responseError: nil))
    }
    
    @MainActor
    func sendTapped() async {
        let text = inputMessage
        inputMessage = ""
        await send(text: text)
    }
    
    @MainActor
    func retry(message: MessageRow) async {
        guard let index = messages.firstIndex(where: {$0.id == message.id}) else {
            return
        }
        
        self.messages.remove(at: index)
        await send(text: message.sendText)
    }
    
    @MainActor
    func send(text: String) async {
        isInteractingWithChatGPT = true
        var streamText = ""
        var messageRow = MessageRow(
            isInteractingWithChatGPT: true, sendImage: "user", sendText: text, responseImage: "swift", responseText: streamText, responseError: nil
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
