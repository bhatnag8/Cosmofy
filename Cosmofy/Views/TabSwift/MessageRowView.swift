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
        HStack(alignment: .top, spacing: 12) {
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
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(splitTextByTripleBackticks(text: text), id: \.self) { segment in
                    if segment.isCode {
                        VStack {
                            Divider()
                            Text(segment.text)
                                .multilineTextAlignment(.leading)
                                .textSelection(.enabled)
                                .font(.system(.footnote, design: .monospaced))
                                .bold()
                            Divider()
                        }
                    } else {
                        Text(segment.text)
                            .multilineTextAlignment(.leading)
                            .textSelection(.enabled)
                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
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
                        .frame(width: 50, height: 25)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color)
    }
}


// Helper function to split text into segments based on triple backticks
func splitTextByTripleBackticks(text: String) -> [Segment] {
    var segments: [Segment] = []
    var currentText = ""
    var isCodeBlock = false
    
    for char in text {
        if char == "`" {
            if currentText.hasSuffix("``") {
                isCodeBlock = !isCodeBlock
                segments.append(Segment(text: String(currentText.dropLast(2)), isCode: !isCodeBlock))
                currentText = ""
            } else {
                currentText.append(char)
            }
        } else {
            currentText.append(char)
        }
    }
    
    segments.append(Segment(text: currentText, isCode: isCodeBlock))
    return segments
}

// Struct to represent a text segment with information whether it's a code block or not
struct Segment: Hashable {
    let text: String
    let isCode: Bool
}

