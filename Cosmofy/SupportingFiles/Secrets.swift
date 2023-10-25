//
//  Secrets.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 10/25/23.
//

import Foundation

struct Secrets {
    private static func secrets() -> [String: Any] {
        let fileName = "Secrets"
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        } else {
            // Handle the case when the file is not found
            fatalError("Secrets.json not found in the app bundle.")
        }

    }

    static var apiKey: String {
        return secrets()["API_KEY"] as! String
    }


}
