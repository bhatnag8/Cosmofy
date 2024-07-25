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
    
    @StateObject private var viewModelAPOD = ViewModelAPOD()
    @State private var fetchComplete = false
    @State private var fetchFailed = false
    
    var body: some View {
        TabView {
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                Home(viewModel: viewModelAPOD)
                    .tabItem {
                        Label("Home", image: "tab-bar-home")
                    }
            } else {
                iPadHome()
                    .tabItem {
                        Label("Home", image: "tab-bar-home")
                    }
            }
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                PlanetsView()
                    .tabItem {
                        Label("Planets", image: "tab-bar-planets")
                    }
            } else {
                iPadPlanetsView()
                    .tabItem {
                        Label("Planets", image: "tab-bar-planets")
                    }
            }   
            
            SwiftView()
                .tabItem {
                    Label("Swift", image: "tab-bar-swift")
                }
            
            RNNMaybach(complete: $fetchComplete, failed: $fetchFailed)
                .tabItem {
                    Label("Nature Scope", image: "tab-bar-roadmap")
                }
            
            
        }
        .tint(.primary)
        //        .background(Color(.systemBackground).edgesIgnoringSafeArea(.all)) // Set the background color of TabView
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont(descriptor: UIFont.systemFont(ofSize: 34, weight: .semibold).fontDescriptor.withDesign(.rounded)!, size: 34),
            ]
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
            
            viewModelAPOD.fetch()

        }
    }
}

#Preview {
    TabBarView()
}
