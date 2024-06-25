//
//  ContentView.swift
//  WatchCosmofy Watch App
//
//  Created by Arryan Bhatnagar on 6/15/24.
//

import SwiftUI
import Combine

struct ContentViewWatch: View {
    
    @State private var selectedIndex = 1
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            LeftView()
                .tag(0)
            
            CenterView()
                .tag(1)
            
            RightView()
                .tag(2)
        }
        
    }
}

#Preview {
    CenterView()
}


struct CenterView: View {
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                /*
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: 0xD2DFF7), // Top-left
                        Color(hex: 0xE1E8F4), // Top-right
                        Color(hex: 0xC8D5F1), // Bottom-right
                        Color(hex: 0xB7C5F4)  // Bottom-left
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                 */
                
                Image("home-banner-1")
                    .resizable()
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    VStack {
                        VStack {
                            HStack {
                                Spacer()
                                Text("Cosmofy")
                                    .font(.title2)
                                    .fontWidth(.standard)
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            
                            Text("1.2")
                                .font(.headline)
                                .textCase(.uppercase)
                                .foregroundStyle(.secondary)

//                            Text("- 1.2 -")
//                                .fontDesign(.rounded)
//                                .italic()
//                                .fontDesign(.serif)
//                                .font(.title3)
                        }
                        .padding()
                        
                        AstroView()
//                            .environment(\.colorScheme, .light)
                            .padding(.vertical)
                        
                    }
                }
                .background(.ultraThinMaterial)
                
                
            }
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    ShareLink(item: URL(string: "https://apps.apple.com/app/cosmofy/id6450969556")!, preview: SharePreview("Cosmofy on the Apple App Store", image: Image("iconApp")))
                }
            }
            
        }
        
        
    }
}

struct AstroView: View {
    @StateObject private var astroService = AstroService()
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            
            
            if let astroResponse = astroService.astroResponse {
                
                HStack {
                    Text("There are \(astroResponse.number) in Space at this Very Moment")
                        .multilineTextAlignment(.leading)
                    
                    Spacer(minLength: 12)
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut, value: isExpanded)
                }
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .padding(.bottom)

                
                if isExpanded {
                    ForEach(astroResponse.people) { person in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(person.name)
                                    .bold()
                                    .multilineTextAlignment(.leading)
                                    .font(.caption)
                                Spacer()
                            }
                            HStack {
                                Text(person.craft)
                                    .foregroundStyle(.secondary)
                                    .italic()
                                    .font(.caption2)
                                Spacer()
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .transition(.opacity)
                    }
                }
            } else if let errorMessage = astroService.errorMessage {
                //                Text("Error: \(errorMessage)")
                //                    .foregroundColor(.red)
            } else {
                //                ProgressView()
                //                    .progressViewStyle(CircularProgressViewStyle())
            }
            
            
            Spacer()
        }
        .padding()
        .onAppear() {
            astroService.fetchAstros()
        }
    }
}



struct AstroResponse: Codable {
    let people: [Person]
    let number: Int
    let message: String
}

struct Person: Codable, Identifiable {
    let craft: String
    let name: String
    
    var id: UUID { UUID() }  // Computed property to generate a unique ID
}

class AstroService: ObservableObject {
    @Published var astroResponse: AstroResponse?
    @Published var errorMessage: String?
    
    private var cancellable: AnyCancellable?
    
    func fetchAstros() {
        guard let url = URL(string: "https://api.arryan.xyz:6969/get-astros") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: AstroResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { response in
                self.astroResponse = response
            })
    }
}



