//
//  Home.swift
//  Cosmofy for TV
//
//  Created by Arryan Bhatnagar on 7/16/24.
//

import Foundation
import SwiftUI

struct Home: View {
    @State private var trigger: Bool = false
    @ObservedObject var viewModel = ViewModelAPOD()
    @State var fetched: Bool = false

    var body: some View {

            HStack {
                
                // MARK: View 2
                VStack {
                    HStack {
                        Text("Astronomy Picture of the Day")
                            .textCase(.uppercase)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    Divider()
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .padding()
                            .foregroundColor(.red)
                    } else if let apod = viewModel.apod {
                        if apod.media_type == "image" {
                                                        
                            ImageView(apod.url)
                                .aspectRatio(contentMode: .fit)
                                .padding(.vertical)
                                .padding(.trailing, 32)
//                                .frame(maxHeight: 1000)
//                            Spacer()
                        } else if apod.media_type == "video" {

                            Text("Video content cannot be displayed on Apple TV. Please view it on Cosmofy on your iPhone.")
                                .padding(.vertical)
                                .padding(.horizontal, 32)
                                .foregroundStyle(.red)
                        }
                    } else {
                        ProgressView("Loading...")
                            .padding()
                    }
                        


                    
                    
                    
                    Spacer()

                }
                
                
                // MARK: View 1
                VStack {
                    HStack {
                        Text("description")
                            .textCase(.uppercase)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    Divider()
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .padding()
                            .foregroundColor(.red)
                    } else if let apod = viewModel.apod {
                        VStack {
                            HStack {
                                Text(apod.title)
                                    .bold()
                                    .fontWidth(.compressed)
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack {
                                Text(convertDateString(dateString: apod.date))
                                    .italic()
                                    .fontDesign(.serif)
                                Spacer()
                            }
                            
                            
                            if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage)
                                    .padding()
                                    .foregroundColor(.red)
                            } else if let apod = viewModel.apod {
                                VStack {
                                    Text(apod.explanation)
                                        .font(.caption2)
                                        .padding(.vertical)
                                        .italic()
                                        .fontDesign(.serif)
                                }
                            } else {
                                ProgressView("Loading...")
                                    .padding()
                            }
                            
                            
                        }
                    } else {
                        ProgressView("Loading...")
                            .padding()
                    }
                    Spacer()

                }


            }
        
        .onAppear {
            if !fetched {
                viewModel.fetch()
                fetched = true
            }
        }
    }
}

