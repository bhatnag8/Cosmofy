//  ========================================
//  MessageRowView.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 10/24/23.
//  Abstract: UI for each row of the Chat VStack.
//  ========================================

import SwiftUI

struct MessageRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    let message: MessageRow
    let retryCallback: (MessageRow) -> Void
    var body: some View {
        VStack(spacing: 0) {
            messageRow(text: message.sendText, image: message.sendImage, color: colorScheme == .light ? .white : Color(red: 20/255, green: 20/255, blue: 25/255, opacity: 1))
            
            
            if let text = message.responseText {
                Divider()
                messageRow(text: text, image: message.responseImage, color: colorScheme == .light ? .white : Color(red: 24/255, green: 24/255, blue: 27/255, opacity: 1), responseError: message.responseError, showDotLoading: message.isInteractingWithChatGPT)
                Divider()
            }
        }
    }
    
    func messageRow(text: String, image: String, color: Color, responseError: String? = nil, showDotLoading: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 24) {
            if image.hasPrefix("http"), let url = URL(string: image) {
                AsyncImage(url: url) {
                    image in image
                        .resizable()
                        .frame(width: 25, height: 25)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(image)
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            
            VStack(alignment: .leading) {
                if !text.isEmpty {
    
                    if text.contains("```") {
                        let cleanedText = text.replacingOccurrences(of: "```", with: "")
                        Text(cleanedText)
                            .multilineTextAlignment(.leading)
                            .textSelection(.enabled)
                            .font(.system(.footnote, design: .monospaced))
                    }
                    else {
                        Text(text)
                            .multilineTextAlignment(.leading)
                            .textSelection(.enabled)
                            
                    }
                    
                }
                
                if let error = responseError {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    
                    Button("Regenerate Response") {
                        retryCallback(message)
                    }
                    .foregroundColor(.accentColor)
                    .padding(.top)
                }
                
                if showDotLoading {
                    LoadingView()
                        .frame(width: 60, height: 30)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color)
    }
}

