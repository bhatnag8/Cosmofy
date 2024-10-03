//
//  iPadHome.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 6/27/24.
//

import SwiftUI
import UIKit

struct iPadHome: View {
    @State private var trigger: Bool = false
    @ObservedObject var viewModel = ViewModelAPOD()
    @State var fetched: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        
                        
                        
                        
                        // View 1
                        VStack {
                                
                                VStack {
                                    HStack {
                                        Text("Astronomy Picture of the Day")
                                            .textCase(.uppercase)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    Divider()
                                        .padding(.horizontal)
                                }
                                .padding([.horizontal, .top])
                                
                                if let errorMessage = viewModel.errorMessage {
                                    Text(errorMessage)
                                        .padding()
                                        .foregroundColor(.red)
                                } else if let apod = viewModel.apod {
                                    VStack {
                                        
                                        VStack {
                                            HStack {
                                                Text(apod.title)
                                                    .bold()
                                                    .fontWidth(.compressed)
                                                    .font(.title)
                                                    .multilineTextAlignment(.leading)
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                            
                                            HStack {
                                                Text(convertDateString(dateString: apod.date))
                                                    .italic()
                                                    .fontDesign(.serif)
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                            
                                        }
                                        .padding(.horizontal)
                                        
                                        
                                        if apod.media_type == "image" {
                                            ImageView(apod.url)
                                                .aspectRatio(contentMode: .fit)
                                                .padding(.vertical)
                                                .padding(.horizontal, 32)
                                        } else if apod.media_type == "video" {
                                            
                                            #if !os(tvOS)
                                            WebView(urlString: apod.url)
                                                .frame(height: 300)
                                                .padding(.vertical)
                                            #endif
                                        }
                                        
                                        Text(apod.explanation)
                                            .padding(.horizontal, 32)
                                            .italic()
                                            .fontDesign(.serif)
                                            
                                        
                                        Spacer()
                                        
                                    }
                                } else {
                                    ProgressView("Loading...")
                                        .padding()
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .onAppear {
                            if !fetched {
                                viewModel.fetch()
                                fetched = true
                            }
                        }
                        
                        // View 2
                        VStack {
                            VStack {
                                HStack {
                                    Text("article of the month")
                                        .textCase(.uppercase)
                                        .foregroundStyle(.secondary)
                                    Spacer()

                                }
                                Divider()
                            }
                            .padding(.top)
                            .padding(.horizontal, 32)
                            
                            VStack(spacing: 32) {
                                NavigationLink(destination: OctoberView()) {
                                    VStack(spacing: 0) {
                                        Image("October Article")
                                            .resizable()
                                            .scaledToFit()
                                        HStack {
                                            VStack {
                                                Text("10")
                                                    .font(.largeTitle)
                                                    .fontDesign(.serif)
                                                
                                                Text("2024")
                                                    .fontDesign(.serif)
                                                    .foregroundStyle(.secondary)
                                            }
                                            
                                            
                                            VStack(spacing: 4) {
                                                HStack {
                                                    Text("The #1 Clue to Quantum Gravity Sits on the Surfaces of Black Holes")
                                                        .multilineTextAlignment(.leading)
                                                        .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                                        .foregroundColor(.primary)
                                                    Spacer()
                                                }
                                                
                                                HStack {
                                                    Text("Joseph Howlett")
                                                        .multilineTextAlignment(.leading)
                                                        .font(.caption)
                                                        .italic()
                                                        .fontDesign(.serif)
                                                        .foregroundColor(.secondary)
                                                    Spacer()
                                                }
                                            }
                                            .padding(.leading)
                                            
                                            Spacer()
                                            
                                        }
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                    }
                                    .clipShape(RoundedRectangle.init(cornerRadius: 18))
                                    
                                }
                                NavigationLink(destination: SeptemberView()) {
                                    VStack(spacing: 0) {
                                        
                                        Image("September Article")
                                            .resizable()
                                            .scaledToFit()
                                        HStack {
                                            VStack {
                                                Text("09")
                                                    .font(.largeTitle)
                                                    .fontDesign(.serif)
                                                
                                                Text("2024")
                                                    .fontDesign(.serif)
                                                    .foregroundStyle(.secondary)
                                            }
                                            
                                            
                                            VStack() {
                                                HStack {
                                                    Text("The Webb Telescope Further Deepens the Biggest Controversy in Cosmology")
                                                        .multilineTextAlignment(.leading)
                                                        .font(Font.custom("SF Pro Rounded Regular", size: 16))
                                                        .foregroundColor(.primary)
                                                    Spacer()
                                                }
                                                
                                                HStack {
                                                    Text("Liz Kruesi")
                                                        .multilineTextAlignment(.leading)
                                                        .font(.caption)
                                                        .italic()
                                                        .fontDesign(.serif)
                                                        .foregroundColor(.secondary)
                                                    Spacer()
                                                }
                                            }
                                            .padding(.leading)
                                            
                                            Spacer()
                                            
                                        }
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                    }
                                    .clipShape(RoundedRectangle.init(cornerRadius: 18))
                                    
                                }
                            }
                            
                            .padding(.horizontal, 32)
                            .padding(.top)
                            
                            Spacer()
                            

                        }
                        .frame(maxWidth: .infinity)



                    }
                }
            }
            
            .navigationTitle("Cosmofy")
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                ]
            }
        }
    }
}





struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        return UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}
