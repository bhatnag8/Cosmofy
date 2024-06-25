//
//  TabBarView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
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
            
            RNNMaybach()
                .tabItem {
                    Label("Nature Scope", image: "tab-bar-roadmap")
                }
            
            
        }
        .tint(.primary)
        //        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all)) // Set the background color of TabView
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
            ]
            NetworkManager().fetchEvents { result in
                switch result {
                case .success(let events):
                    fetchedEvents = events
                    print("Nature Scope: All Events Fetched")
                case .failure(let error):
                    fetchedErrorMessage = error.localizedDescription
                    print("Nature Scope: Failed to Fetch Events")
                }
            }
            
            
        }
    }
}

#Preview {
    TabBarView()
}
