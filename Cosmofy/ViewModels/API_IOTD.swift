//
//  API_IOTD.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/15/24.
//

import Foundation

class ViewModelAPOD: ObservableObject {
    @Published var apod: APOD?
    init() {
        self.fetch()
    }
}

extension ViewModelAPOD {
    func fetch() {
        API_IOTD.getImageOfTheDay { apod in
            self.apod = apod
        }
    }
}

class API_IOTD {
    class func getImageOfTheDay(_ onSuccess: @escaping (APOD) -> Void) {
        Constants.session.dataTask(with: Constants.request) { data, response, error in
            guard let data = data, error == nil else {
                fatalError()
            }
            
            do {
                let apod = try Constants.decoder.decode(APOD.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(apod)
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        .resume()
    }
}
