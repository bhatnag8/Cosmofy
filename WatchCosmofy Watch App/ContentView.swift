//
//  ContentView.swift
//  WatchCosmofy Watch App
//
//  Created by Arryan Bhatnagar on 6/15/24.
//

import SwiftUI

struct ContentViewWatch: View {
    var body: some View {
        TabView {

            ForEach(allPlanets) { planet in
                ZStack {
                    PlanetPreview(planet: planet)
                        .containerBackground(planet.color.gradient, for: .tabView)
                }
                
            }
        }
        .tabViewStyle(.verticalPage)
    }
}

#Preview {
    ContentViewWatch()
}


struct PlanetPreview: View {
    
    let planet: Planet
    var body: some View {
        VStack {
            Image(planet.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 65)
            Spacer()
            HStack {
                Text(planet.name)
                    .font(.title2)
                Spacer()
            }
            HStack {
                Text(planet.description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            
            
        }
        .padding(.horizontal)
    }
}
