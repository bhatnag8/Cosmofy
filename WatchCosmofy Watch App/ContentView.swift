//
//  ContentView.swift
//  WatchCosmofy Watch App
//
//  Created by Arryan Bhatnagar on 6/15/24.
//

import SwiftUI

struct ContentViewWatch: View {
    
    @State private var selectedIndex = 1

    var body: some View {
        TabView(selection: $selectedIndex) {
            LeftView()
                .tag(0)

            CenterView()
                .tag(1)
            
            RightView()
                .tag(2)
        }
    }
}

#Preview {
    ContentViewWatch()
}

struct LeftView: View {
    var body: some View {
        VStack {
            Text("Left")
        }
    }
}

struct CenterView: View {
    var body: some View {
        VStack {
            Text("Center")
        }
    }
}

struct RightView: View {
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
