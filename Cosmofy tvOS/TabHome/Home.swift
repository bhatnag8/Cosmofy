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
                // MARK: View 1
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
                            
                            
//                            if apod.media_type == "image" {
//                                ImageView(apod.url)
//                                    .aspectRatio(contentMode: .fit)
//                                    .padding()
//                                    .frame(maxHeight: 1000)
//                            } else if apod.media_type == "video" {
//
//                                #if !os(tvOS)
//                                WebView(urlString: apod.url)
//                                    .frame(height: 300)
//                                    .padding(.horizontal)
//                                #endif
//                            }
                            
                            if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage)
                                    .padding()
                                    .foregroundColor(.red)
                            } else if let apod = viewModel.apod {
                                VStack {
                                    Text(apod.explanation)
                                        .font(.caption2)
                                        .padding()
                                        .italic()
                                        .fontDesign(.serif)
                                }
                            } else {
                                ProgressView("Loading...")
                                    .padding()
                            }
                            
                            Spacer()
                        }
                    } else {
                        ProgressView("Loading...")
                            .padding()
                    }

                }

                // MARK: View 2
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
                        if apod.media_type == "image" {
                            ImageView(apod.url)
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .frame(maxHeight: 1000)
                        } else if apod.media_type == "video" {

                            #if !os(tvOS)
                            WebView(urlString: apod.url)
                                .frame(height: 300)
                                .padding(.horizontal)
                            #endif
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

