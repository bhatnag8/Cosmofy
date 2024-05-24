//
//  TabBarView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var isLoading = true
    
    init() {
            UITabBar.appearance().backgroundColor = UIColor.systemBackground
        }
    
    var body: some View {
        TabView {
            RNNMaybach(isLoading: $isLoading)
                .tabItem {
                    Label("Earth Scope", image: "tab-bar-roadmap")
                }
                .onAppear(perform: {Haptics.shared.impact(for: .medium)})
            
            Home()
                .tabItem {
                    Label("Home", image: "tab-bar-home")
                }
                .onAppear(perform: {Haptics.shared.impact(for: .medium)})
            
            PlanetsView()
                .tabItem {
                    Label("Planets", image: "tab-bar-planets")
                }
            
            SwiftView()
                .tabItem {
                    Label("Swift", image: "tab-bar-swift")
                }
                .onAppear(perform: {Haptics.shared.impact(for: .medium)})

            
        }
        .tint(.primary)
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all)) // Set the background color of TabView
        .onAppear {
            NetworkManager().fetchEvents { result in
                switch result {
                    case .success(let events):
                        fetchedEvents = events
                        isLoading = false
                    case .failure(let error):
                        fetchedErrorMessage = error.localizedDescription
                        isLoading = false
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
