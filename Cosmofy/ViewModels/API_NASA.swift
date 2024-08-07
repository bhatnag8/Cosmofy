//
//  API_IOTD.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/15/24.
//

import Foundation

class ViewModelAPOD: ObservableObject {
    @Published var apod: APOD?
    @Published var errorMessage: String?

    func fetch(for date: String? = nil) {
        API_IOTD.getImageOfTheDay(for: date) { apod, error in
            if let error = error {
                self.errorMessage = "Failed to fetch data: \(error.localizedDescription)."
            } else if let apod = apod {
                self.apod = apod
            }
        }
    }
}

class API_IOTD {
    class func getImageOfTheDay(for date: String? = nil, _ completion: @escaping (APOD?, Error?) -> Void) {
        Constants.session.dataTask(with: Constants.request(for: date)) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                let apod = try Constants.decoder.decode(APOD.self, from: data)
                DispatchQueue.main.async {
                    completion(apod, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        .resume()
    }
}

