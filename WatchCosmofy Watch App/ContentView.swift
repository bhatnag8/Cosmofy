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
    @StateObject private var astroService = AstroService()

    var body: some View {
        
        NavigationStack {
            ZStack {
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
                
                ScrollView {
                    VStack {
                        HStack {
                            VStack {
                                HStack {
                                    Text("Cosmofy")
                                        .font(.title3)
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                HStack {
                                    Text("v1.0").foregroundStyle(.black)
                                    Spacer()
                                }
                            }
                            Spacer()
                            Image("app-icon-4k")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                        }
                        .padding(.horizontal)

                        if let astroResponse = astroService.astroResponse {
                            ForEach(astroResponse.people) { person in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(person.name)
                                            .font(.caption)
                                            .foregroundStyle(.black)

                                        Spacer()
                                    }
                                    HStack {
                                        Text("Spacecraft: \(person.craft)")
                                            .font(.caption2)
                                            .foregroundStyle(.GUTS)
                                        Spacer()
                                    }
                                }
                                .padding()
                                .clipShape(.rect(cornerRadius: 12))
                                .background(.ultraThinMaterial)
                                .environment(\.colorScheme, .light)

                            }
                        } else if let errorMessage = astroService.errorMessage {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                        } else {
                            ProgressView().progressViewStyle(.circular)
                        }
                        
                    }
                }
                
                
            }
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    ShareLink(item: URL(string: "https://apps.apple.com/app/cosmofy/id6450969556")!, preview: SharePreview("Cosmofy on the Apple App Store", image: Image("iconApp")))
                }
            }
            
        }
        .onAppear {
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


struct ShimmerEffectBox: View {
    private var gradientColors = [
        Color(uiColor: UIColor.lightGray),
        Color(uiColor: UIColor.gray),
        Color(uiColor: UIColor.darkGray)
    ]
    @State var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    var body: some View {
        LinearGradient (colors: gradientColors,
                        startPoint: startPoint,
                        endPoint: endPoint)
        .onAppear {
            withAnimation (.easeInOut (duration: 1)
                .repeatForever (autoreverses: false)) {
                    startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
                }
        }
    }
}

