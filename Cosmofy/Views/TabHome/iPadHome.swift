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
                            
                            NavigationLink(destination: AugustView()) {
                                
                                ZStack(alignment: .bottom) {
                                    
                                    Image("August Article")
                                        .resizable()
                                        .scaledToFit()
                                    
                                    VStack {
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")
                                        Text(" ")

                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        VisualEffectView(effect: UIBlurEffect(style: .dark))
                                                    )
                                    
                                        
                                    Image("August Article")
                                        .resizable()
                                        .scaledToFit()
                                        .mask(LinearGradient(stops: [.init(color: .white, location: 0),
                                                                                     .init(color: .white, location: 0.4),
                                                                                     .init(color: .clear, location: 0.80),], startPoint: .top, endPoint: .bottom))
                                    
                                    
                                    HStack {
                                        VStack {
                                            Text("08")
                                                .font(.largeTitle)
                                                .fontDesign(.serif)
                                                .foregroundStyle(.white)
                                            
                                            Text("2024")
                                                .fontDesign(.serif)
                                                .foregroundStyle(Color.gray.opacity(0.6))
//                                                .foregroundStyle(.white)

                                        }
                                        
                                        VStack() {
                                            HStack {
                                                Text("The Best Neighborhoods for Starting a Life in the Galaxy")
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.custom("SF Pro Rounded Regular", size: 18))
                                                    .foregroundStyle(.white)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Text("Rebecca Boyle")
                                                    .multilineTextAlignment(.leading)
                                                    .italic()
                                                        .fontDesign(.serif)
                                                        .foregroundStyle(Color.gray.opacity(0.6))
                                                Spacer()
                                            }
                                            
                                        }
                                        .padding(.leading)
                                                                                    
                                    }
                                    .padding()

                                }
                                .clipShape(RoundedRectangle.init(cornerRadius: 18))

                                
                            }
                            .padding(.horizontal, 32)
                            .padding(.top)
                            
                            VStack {
                                HStack {
                                    Text("Astronauts in space")
                                        .textCase(.uppercase)
                                        .foregroundStyle(.secondary)
                                    Spacer()

                                }
                                Divider()
                            }
                            .padding(.top)
                            .padding(.horizontal, 32)
                            
                            iPadAstroView()
                                .padding(.horizontal, 32)
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




struct iPadAstroView: View {
    @StateObject private var astroService = AstroService()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let astroResponse = astroService.astroResponse {
                        ForEach(astroResponse.people, id: \.id) { person in
                            NavigationLink(destination: iPadAstronautView(person: person)) {
                                HStack(spacing: 8) {
                                    Image(person.flag_code)
                                        .resizable()
                                        .frame(width: 50)
                                        .frame(height: 30)
                                        .border(.gray)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
//                                        .aspectRatio(contentMode: .fit)
                                    VStack {
                                        
                                        HStack {
                                            Text(person.name)
                                                .bold()
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        
                                        
                                        HStack {
                                            Text(person.position)
                                                .foregroundStyle(.secondary)
                                                .multilineTextAlignment(.leading)
                                                .font(.headline)
                                            Spacer()
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                    
                                    Spacer()
                                    Text(person.agency)
                                        .foregroundStyle(.secondary)
//                                        .italic()
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        
                        
                    } else if astroService.errorMessage != nil {
                        Text("Error: \(astroService.errorMessage ?? "Failed to Fetch Response")")
                                .foregroundColor(.red)
                    } else {
                        ProgressView()
                    }
                }
                .onAppear() {
                    astroService.fetchAstros()
                }
            }
        }
        
        
    }
}

struct iPadAstronautView: View {
    @Environment(\.presentationMode) var presentationMode

    let person: Person

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 16) {
                        Image(systemName: "chevron.left")
                            .font(.caption)

                        Text("Back")
                            .font(.caption)
                    }
                }
                Spacer()
            }
            .padding()
            
            
            AsyncImage(url: URL(string: person.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.red)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 300, height: 200)

            Text(person.name)
                .font(.title)
                .padding()
            Text(person.agency)
                .font(.subheadline)
            Text(person.country)
                .font(.subheadline)
            Text(person.position)
                .font(.subheadline)
            Text(person.spacecraft)
                .font(.subheadline)
            
            Spacer()
        }
        .navigationBarHidden(true) // Hides the default navigation bar
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
