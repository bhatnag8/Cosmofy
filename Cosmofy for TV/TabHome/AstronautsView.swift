//
//  AstronautsView.swift
//  Cosmofy for TV
//
//  Created by Arryan Bhatnagar on 7/22/24.
//

import Foundation
import SwiftUI

struct AstronautsView: View {
    @StateObject private var astroService = AstroService()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let astroResponse = astroService.astroResponse {
                        ForEach(astroResponse.people, id: \.id) { person in
                            NavigationLink(destination: AstronautView(person: person)) {
                                HStack(spacing: 16) {
                                    
                                    Image(person.flag_code)
                                        .resizable()
                                        .frame(width: 60)
                                        .frame(height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                    
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
                                        .font(.caption2)
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
                    
                    
                    Spacer()
                }
                .onAppear() {
                    astroService.fetchAstros()
                }
            }
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
        .navigationBarHidden(true)
    }
}

