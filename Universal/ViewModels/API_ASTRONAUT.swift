//
//  API_ASTRONAUT.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 7/16/24.
//

import Foundation
import Combine

struct AstroResponse: Codable {
    let number: Int
    let people: [Person]
}

struct Person: Codable, Identifiable {
    let id: Int
    let name: String
    let country: String
    let flag_code: String
    let agency: String
    let position: String
    let spacecraft: String
    let url: String
    let image: String
}

class AstroService: ObservableObject {
    @Published var astroResponse: AstroResponse?
    @Published var errorMessage: String?
    
    private var cancellable: AnyCancellable?
    
    func fetchAstros() {
        guard let url = URL(string: "https://astronaut-api.p.rapidapi.com/astronauts") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("5ffe76ed10mshf8737502ab5127bp167ab8jsne53a9ad058a6", forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("astronaut-api.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: AstroResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { response in
//                print("Decoded response: \(response)")
                self.astroResponse = response
            })
    }
}
