//
//  API_EONET.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 5/7/24.
//

import Foundation

class NetworkManager {
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        let urlString = "https://eonet.gsfc.nasa.gov/api/v3/events?start=\(getDate14DaysAgo())&end=2026-12-31&status=all"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
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

func getDate14DaysAgo() -> String {
    // Get the current date
    let currentDate = Date()
    
    // Subtract 14 days from the current date
    guard let date14DaysAgo = Calendar.current.date(byAdding: .day, value: -15, to: currentDate) else {
        return "Date calculation error"
    }
    
    // Format the date as yyyy-MM-dd
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    print("Nature Scope: Fetching from \(dateFormatter.string(from: date14DaysAgo))")
    return dateFormatter.string(from: date14DaysAgo)
}
