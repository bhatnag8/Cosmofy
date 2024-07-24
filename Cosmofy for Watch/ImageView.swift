//
//  ImageView.swift
//  WatchCosmofy Watch App
//
//  Created by Arryan Bhatnagar on 6/17/24.
//

import Foundation
import SwiftUI

struct LeftView: View {
    var body: some View {
        IOTDView()
    }
}

// View for displaying APOD content on watchOS
struct IOTDView: View {
    @ObservedObject var viewModel = ViewModelAPOD()
    @State var fetched: Bool = false
    
    var body: some View {
        ScrollView {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .padding()
                    .foregroundColor(.red)
            } else if let apod = viewModel.apod {
                VStack {
                    HStack {
                        Text("Astronomy Picture of the Day")
                            .font(.headline)
                            .textCase(.uppercase)
                            .foregroundStyle(.secondary)

                        Spacer()
                    }
                    .padding([.bottom, .horizontal])

//                    HStack {
//                        Text("from NASA")
//                            .font(.headline)
//                            .foregroundStyle(.secondary)
//                        Spacer()
//                    }
//                    .padding([.bottom, .horizontal])
                    
                    Divider()
                    
                    VStack {
                        HStack {
                            Text(apod.title)
                                .bold()
                                .fontWidth(.compressed)
                                .font(.title2)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(.horizontal)
                        HStack {
                            Text(convertDateString(dateString: apod.date))
                                .italic()
                                .font(.body)
                                .fontDesign(.serif)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    
                    
                    if apod.media_type == "image" {
                        ImageView(apod.url)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    } else if apod.media_type == "video" {
                        VStack {
                            Text("Video content cannot be displayed on Watch. Please view it on your iPhone.")
                                .padding()
                                .font(.caption2)
                                .foregroundStyle(.red)
                        }
                        .padding()
                    }
                    
                    VStack {
                        HStack {
                            Text("a brief explanation")
                                .font(.headline)
                                .textCase(.uppercase)
                                .foregroundStyle(.secondary)
                            Spacer()
                        }
                        Divider()
                            .tint(.secondary)
                    }
                    .padding([.top, .horizontal])
                    
                    Text(apod.explanation)
                        .italic()
                        .fontDesign(.serif)
                        .font(.caption)
                        .padding()
                }
            } else {
                ProgressView("Loading...")
                    .padding()
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

// View for displaying images
struct ImageView: View {
    @ObservedObject var imageLoader = ImageLoader()
    
    init(_ url: String) {
        self.imageLoader.load(url)
    }
    
    var body: some View {
        if let image = imageLoader.downloadedImage {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            ProgressView("Loading...")
                .padding()
        }
    }
}


func convertDateString(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let date = dateFormatter.date(from: dateString) else {
        return "Invalid date"
    }
    
    dateFormatter.dateStyle = .full
    return dateFormatter.string(from: date)
}
