//
//  Profile.swift
//  Cosmofy iOS
//
//  Created by Arryan Bhatnagar on 8/2/24.
//

import SwiftUI

struct Profile: View {
    @AppStorage("selectedProfile") var selectedProfile: Int?

    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    VStack {
                        HStack() {
                            Text("Cosmic Expert")
                                .fontDesign(.rounded)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            if selectedProfile == 3 {
                                HStack {
                                    Text("Selected")
                                        .foregroundStyle(.green)
                                        .fontDesign(.rounded)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                        .padding()
                        HStack() {
                            Text("Advanced understanding of space for enthusiasts and professionals.")
                                .foregroundStyle(.secondary)
                                .fontDesign(.rounded)
                            Spacer()
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 130)
                    .background(.ultraThinMaterial)
                    .onTapGesture {
                        selectedProfile = 3
                    }
                    
                   Divider()
                    
                    VStack {
                        HStack() {
                            Text("Stellar Scholar")
                                .fontDesign(.rounded)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            if selectedProfile == 2 {
                                HStack {
                                    Text("Selected")
                                        .foregroundStyle(.green)
                                        .fontDesign(.rounded)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                        .padding()
                        HStack() {
                            Text("Intermediate knowledge of space, perfect for curious minds.")
                                .foregroundStyle(.secondary)
                                .fontDesign(.rounded)
                            Spacer()
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 130)
                    .background(.ultraThinMaterial)
                    .onTapGesture {
                        selectedProfile = 2
                    }

                    Divider()
                    
                    VStack {
                        HStack() {
                            Text("kids")
                                .foregroundStyle(Color(hex: 0xFAF42A))
                                .fontDesign(.rounded)
                                .font(.title2)
                                .frame(width: 70)
                                .fontWeight(.semibold)
                                .background(
                                    VStack(spacing: 0) {
                                        Rectangle().fill(Color.pink.opacity(0.8).gradient)
                                        Rectangle().fill(Color.purple.opacity(0.8).gradient)
                                        Rectangle().fill(Color.blue.opacity(0.8).gradient)
                                        Rectangle().fill(Color.green.opacity(0.8).gradient)
                                    }
                                    .frame(width: 80, height: 80)
                                    .rotationEffect(.degrees(45))
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .clipped()
                            Spacer()
                            if selectedProfile == 1 {
                                HStack {
                                    Text("Selected")
                                        .foregroundStyle(.green)
                                        .fontDesign(.rounded)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                        .padding()
                        HStack() {
                            Text("Basic introduction to space concepts for young learners.")
                                .foregroundStyle(.secondary)
                                .fontDesign(.rounded)
                            Spacer()
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 130)
                    .background(.ultraThinMaterial)
                    .onTapGesture {
                        selectedProfile = 1
                    }
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding()
                
                Spacer()
            }
            
            .navigationTitle("Profile")
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont(descriptor: UIFont.systemFont(ofSize: 34, weight: .semibold).fontDescriptor.withDesign(.rounded)!, size: 34),
            ]
        }

    }
    
}

#Preview {
    Profile()
}
