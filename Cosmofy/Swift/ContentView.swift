//
//  ContentView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 10/24/23.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = SwiftViewModel(api: SwiftAPI())
    @State private var userTouched = false
    @FocusState var isTextFieldFocused: Bool
    @State private var hasAppeared = false
    
    var body: some View {
        chatListView
//            .onAppear {
//                if !hasAppeared {
//                    Task {
//                        @MainActor in await vm.send(text: "Hi, who are you?")
//                    }
//                    hasAppeared = true
//                }
//            }
    }
    
    var chatListView: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 0) {
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.messages) {
                            message in MessageRowView(message: message) {
                                message in
                                
                                Task {
                                    @MainActor in await vm.retry(message: message)
                                }
                            }
                        }
                        .gesture(
                           DragGesture()
                            .onChanged { _ in
                                 print("Touch")
                                userTouched = true
                           }
                        )
                    }
                    .onTapGesture {
                        isTextFieldFocused = false
                    }
                }
                
                Divider()
                bottomView(image: "user", proxy: proxy)
                Spacer()
                
            }
            
            .onChange(of: vm.messages.last?.responseText) {
                _ in 
                if !userTouched {
                    scrollToBottom(proxy: proxy)
                }
            }
        }
        
        .background(colorScheme == .light ? .white : Color(red: 26/255, green: 23/255, blue: 27/255, opacity: 1))
    }
    
    func bottomView(image: String, proxy: ScrollViewProxy) -> some View {
        HStack(alignment: .top, spacing: 8) {
            
            HStack {
                if image.hasPrefix("http"), let url = URL(string: image) {
                    AsyncImage(url: url) {
                        image in image
                            .resizable()
                            .frame(width: 30, height: 30)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(image)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                TextField("Send message", text: $vm.inputMessage, axis: .vertical)
//                    .textFieldStyle(.roundedBorder)
                    .border(Color.black, width: 0)
                    
                    .focused($isTextFieldFocused)
                    .disabled(vm.isInteractingWithChatGPT)
                
                if vm.isInteractingWithChatGPT {
                    LoadingView().frame(width: 60, height: 30)
                } else {
                    Button {
                        
                        Task {
                            @MainActor in
                            isTextFieldFocused = false
                            userTouched = false
                            scrollToBottom(proxy: proxy)
                            await vm.sendTapped()
                            

                        }
                        
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 30))
                    }
                    .disabled(vm.inputMessage
                        .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }
                
            }
            .padding()
            .background(Color.black)
            .cornerRadius(10)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let id = vm.messages.last?.id else {
            return
        }
        
        proxy.scrollTo(id, anchor: .bottom)
    }
}

#Preview {
    ContentView()
}
