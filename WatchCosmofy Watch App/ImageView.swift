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
                        Text("Image of the Day")
                            .font(.title2)
                        Spacer()
                    }
                    .padding()
                    
                    Text(apod.title)
                        .font(.caption)
                        .padding(.vertical, 8)
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
                    Text(apod.explanation)
                        .font(.caption2)
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
