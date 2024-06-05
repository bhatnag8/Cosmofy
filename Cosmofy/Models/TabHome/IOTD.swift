//
//  Constants.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/15/24.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var downloadedImage: UIImage? = nil
}

extension ImageLoader {
    func load(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            fatalError("Unable to Parse Image URL")
        }
        Constants.session.dataTask(with: url, completionHandler: imageDataHandler).resume()
    }
    
    func imageDataHandler(data: Data?, res: URLResponse?, error: Error?) {
        guard let data = data, error == nil else {
            DispatchQueue.main.async {
                print("Unable to load image. Please check your internet connection.")
            }
            return
        }
        DispatchQueue.main.async {
            self.downloadedImage = UIImage(data: data)
        }
    }
}

struct APOD: Codable {
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let media_type: String?
    let service_version: String?
    let title: String
    let url: String
}

class Constants {
    static var apiKey: String {
        return Bundle.main.infoDictionary?["API_KEY_NASA"] as! String
        
    }

    static var url: URL {
        guard let url  = URL(string: "https://apod.ellanan.com/api") else {
            fatalError()
        }
        return url
    }
    
    static var session: URLSession {
        let session  = URLSession(configuration: .default)
        return session
    }
    
    static var request: URLRequest {
        let req = URLRequest(url: url)
        return req
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
}
