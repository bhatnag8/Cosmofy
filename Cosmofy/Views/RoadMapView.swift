//
//  RoadMapView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 4/2/24.
//

import SwiftUI

struct RoadMapView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            ScrollView {
                Image("roadmap")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .navigationTitle("Roadmap")
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
            ]
        }

    }
}

#Preview {
    RoadMapView()
}
