//
//  API_EONET.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 5/7/24.
//

import Foundation

class NetworkManager {
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        let urlString = "https://eonet.gsfc.nasa.gov/api/v3/events?start=2024-01-01&end=2024-12-31"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            /**
                let jsonString = String(data: data!, encoding: .utf8)
                print(jsonString ?? "No valid JSON")
             */
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let eventsResponse = try decoder.decode(EventsResponse.self, from: data)
                completion(.success(eventsResponse.events))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
