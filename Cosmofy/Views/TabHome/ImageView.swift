//
//  ImageLoader.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/15/24.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(_ url: String) {
        self.imageLoader.load(url)
    }
    
    var body: some View {
        if let image = imageLoader.downloadedImage {
            return Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit) // Or use .fill as per your need
        } else {
            return Image("").resizable()
                .aspectRatio(contentMode: .fit) // Or use .fill as per your need
        }
    }
}
