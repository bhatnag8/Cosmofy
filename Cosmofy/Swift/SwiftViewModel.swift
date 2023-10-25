//
//  SwiftViewModel.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 10/24/23.
//

import Foundation
import SwiftUI

class SwiftViewModel: ObservableObject {
    
    @Published var isInteractingWithChatGPT = false
    @Published var messages: [SwiftMessageRow] = []
    @Published var inputMessage: String = ""
    
    private let api: SwiftAPI
    
    init(api: SwiftAPI) {
        self.api = api
    }
    
    @MainActor
    func sendTapped() async {
        let text = inputMessage
        inputMessage = ""
        await send(text: text)
    }
    
    @MainActor
    func retry(message: SwiftMessageRow) async {
        guard let index = messages.firstIndex(where: {$0.id == message.id}) else {
            return
        }
        
        self.messages.remove(at: index)
        await send(text: message.sendText)
    }
    
    @MainActor
    private func send(text: String) async {
        isInteractingWithChatGPT = true
        var streamText = ""
        var messageRow = SwiftMessageRow(
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
