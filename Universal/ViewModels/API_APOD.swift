/*
-----------------------------------------------------------------------------
File Name: API_OPENAI.swift
Description: ...
-----------------------------------------------------------------------------
Creation Date: 3/15/24
-----------------------------------------------------------------------------
Author: Arryan Bhatnagar
Project: Cosmofy 4th Edition
-----------------------------------------------------------------------------
*/

import Foundation

class ViewModelAPOD: ObservableObject {
    @Published var apod: APOD?
    @Published var errorMessage: String?

    func fetch(for date: String? = nil) {
        API_IOTD.getImageOfTheDay(for: date) { apod, error in
            if let error = error {
                self.errorMessage = "Failed to fetch APOD data: \(error.localizedDescription)."
            } else if let apod = apod {
                self.apod = apod
                print("Task: fetched APOD for \(date ?? "default value")")
            }
        }
    }
}

class API_IOTD {
    class func getImageOfTheDay(for date: String? = nil, _ completion: @escaping (APOD?, Error?) -> Void) {
        Constants.session.dataTask(with: Constants.request(for: date)) { data, response, error in
            guard let data = data, error == nil else {
                print("do getImageOfTheDay")

                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                print("do getImageOfTheDay")

                let apod = try Constants.decoder.decode(APOD.self, from: data)
                DispatchQueue.main.async {
                    completion(apod, nil)
                }
            } catch {
                print("catch getImageOfTheDay")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        .resume()
    }
}

