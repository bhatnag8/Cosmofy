//
//  Astronauts.swift
//  Cosmofy iOS
//
//  Created by Arryan Bhatnagar on 7/28/24.
//

import Foundation
import SwiftUI

struct AstronautsView: View {
    @ObservedObject var astroService: AstroService

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Astronauts in Space today")
                        .textCase(.uppercase)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding([.top, .horizontal])
                .padding(.bottom, 8)
                
                if let astroResponse = astroService.astroResponse {
                    ForEach(astroResponse.people, id: \.id) { person in
                        NavigationLink(destination: AstronautView(person: person)) {
                            HStack(spacing: 16) {
                                
                                Image(person.flag_code)
                                    .resizable()
                                    .frame(width: 50)
                                    .frame(height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 2))
                                    .shadow(color: .black.opacity(0.5), radius: 2)
                                
                                VStack {
                                    HStack {
                                        Text(person.name)
                                            .font(.headline)
                                            .fontDesign(.rounded)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    HStack {
                                        Text(person.agency)
                                            .foregroundStyle(.secondary)
                                            .font(.subheadline)
                                            .fontDesign(.rounded)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)

                                }
                                .padding(.trailing)
                                
                                Image(systemName: "chevron.right")
                                    .padding()
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                } else if astroService.errorMessage != nil {
                    Text("Error: \(astroService.errorMessage ?? "Failed to Fetch Response")")
                        .foregroundColor(.red)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .shadow(color: .black.opacity(0.2), radius: 4)
                        .frame(height: 500)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.top)
                        .padding(.horizontal)
                }
                Spacer()
            }
            .background(.ultraThinMaterial)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle.init(cornerRadius: 18))
            .shadow(color: .black.opacity(0.2), radius: 4)
        }
    }
}

struct AstronautView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let person: Person
    
    var body: some View {
        VStack {
            
            
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
        .navigationBarHidden(true)
    }
}
