//
//  Cosmofy_for_TVApp.swift
//  Cosmofy for TV
//
//  Created by Arryan Bhatnagar on 6/30/24.
//

import SwiftUI
import MapKit

@main
struct CosmofyApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}


struct TabBarView: View {
    
    @State private var fetchComplete = false
    @State private var fetchFailed = false
    
    var body: some View {
        TabView {
            
            Home()
                .tabItem {
                    Label("Home", image: "tab-bar-home")
                }
            
            PlanetsView()
                .tabItem {
                    Label("Planets", image: "tab-bar-planets")
                }
            
            SwiftView()
                .tabItem {
                    Label("Swift", image: "tab-bar-swift")
                }
            
            RNNMaybach(complete: $fetchComplete, failed: $fetchFailed)
                .tabItem {
                    Label("Nature Scope", image: "tab-bar-naturescope")
                }

        }
        .tint(.primary)
        .onAppear {
            NetworkManager().fetchEvents { result in
                switch result {
                case .success(let events):
                    fetchedEvents = events
                    fetchComplete = true
                    print("Nature Scope: All Events Fetched")
                case .failure(let error):
                    fetchedErrorMessage = error.localizedDescription
                    fetchFailed = true
                    print("Nature Scope: Failed to Fetch Events")
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
