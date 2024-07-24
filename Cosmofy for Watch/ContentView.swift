//
//  ContentView.swift
//  WatchCosmofy Watch App
//
//  Created by Arryan Bhatnagar on 6/15/24.
//

import SwiftUI
import Combine




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
                            
                            Text("1.3")
                                .font(.headline)
                                .textCase(.uppercase)
                                .foregroundStyle(.secondary)

//                            Text("- 1.3 -")
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
                    Text("There are \(astroResponse.number) People in Space at this Very Moment")
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
//                    ForEach(astroResponse.people) { person in
//                        VStack(alignment: .leading) {
//                            HStack {
//                                Text(person.name)
//                                    .bold()
//                                    .multilineTextAlignment(.leading)
//                                    .font(.caption)
//                                Spacer()
//                            }
//                            HStack {
//                                Text(person.craft)
//                                    .foregroundStyle(.secondary)
//                                    .italic()
//                                    .font(.caption2)
//                                Spacer()
//                            }
//                        }
//                        .padding()
//                        .background(.ultraThinMaterial)
//                        .clipShape(RoundedRectangle(cornerRadius: 12))
//                        .transition(.opacity)
                        
                        ForEach(astroResponse.people, id: \.id) { person in
                            
                            NavigationLink(destination: AstronautView(person: person)) {
                                HStack(spacing: 16) {
                                    Image(person.flag_code)
                                        .resizable()
                                        .frame(width: 60)
                                        .frame(height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
//                                        .aspectRatio(contentMode: .fit)
                                    VStack {
                                        
                                        HStack {
                                            Text(person.name)
                                                .bold()
                                                .multilineTextAlignment(.leading)
                                                .font(.caption)
                                            Spacer()
                                        }
                                        
                                        
                                        HStack {
                                            Text(person.position)
                                                .multilineTextAlignment(.leading)
                                                .font(.caption2)
                                            Spacer()
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                    
                                    Spacer()
                                    Text(person.agency)
                                        .foregroundStyle(.secondary)
//                                        .italic()
                                        .font(.caption2)
                                }
                            }
                            
                        }
                        .padding(.horizontal)
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





struct AstronautView: View {
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

