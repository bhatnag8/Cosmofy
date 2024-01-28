//  ========================================
//  ContentView.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 10/24/23.
//  Abstract: SwiftUI view of SwiftViewController.
//  ========================================

import SwiftUI
import TipKit



struct ContentView: View {

    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = ViewModel(api: API())
    @State private var userTouched = false
    @FocusState var isTextFieldFocused: Bool
    @State private var hasAppeared = false
    
//    let tip = SwiftTip()

    
    var body: some View {
        chatListView
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
                                userTouched = true
                           }
                        )
                        
                    }
                    .onTapGesture {
                        isTextFieldFocused = false
                    }
                }

                .onTapGesture {
                    isTextFieldFocused = false
                }
                
                Divider()
//                TipView(tip)
//                    .onTapGesture {
//                    tip.invalidate(reason: .actionPerformed)
//                }

                bottomView(image: "user", proxy: proxy)

                Spacer()
            }
            .onChange(of: vm.messages.last?.responseText) { _ in
                if !userTouched {
                    scrollToBottom(proxy: proxy)
                }
            }
        }
        .background(colorScheme == .light ? .white : Color(.appColorDarker2))
        
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

                TextField("Send a message", text: $vm.inputMessage, axis: .vertical)
//                    .border(Color.black, width: 0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isTextFieldFocused)
                    .disabled(vm.isInteractingWithChatGPT)
                

                
                if vm.isInteractingWithChatGPT {
                    Button {
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 30))
                            .tint(.red)
                    }


                } else {
                    
                    Button {
                        Task {
                            @MainActor in
                            isTextFieldFocused = false
                            userTouched = false
//                            tip.invalidate(reason: .actionPerformed)
                            scrollToBottom(proxy: proxy)
                            await vm.sendTapped()
                        }
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 30))
                            .tint(.SOUR)
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
        withAnimation {
            proxy.scrollTo(id, anchor: .bottomTrailing)
        }
    }
}

#Preview {
    ContentView()
}
