//
//  TabBarView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject var viewModel: ViewModelAPOD
    @ObservedObject var astroService: AstroService
    
    @Binding var fetchComplete: Bool
    @Binding var fetchFailed: Bool

    var body: some View {
        TabView {
                        
            if UIDevice.current.userInterfaceIdiom == .phone {
                Home(viewModel: viewModel, astroService: astroService)
                    .tabItem {
                        Label("Home", image: "tab-bar-home")
                    }
                
                PlanetsView(complete: $fetchComplete, failed: $fetchFailed)
                    .tabItem {
                        Label("Planets", image: "tab-bar-planets")
                    }
            } else {
                iPadHome()
                    .tabItem {
                        Label("Home", image: "tab-bar-home")
                    }
                
                iPadPlanetsView()
                    .tabItem {
                        Label("Planets", image: "tab-bar-planets")
                    }
            }
            
            SwiftView()
                .tabItem {
                    Label("Swift", image: "tab-bar-swift")
                }
            
            Profile()
                .tabItem {
                    Label("Swift", image: "tab-bar-swift")
                }
        }
        .tint(.primary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont(descriptor: UIFont.systemFont(ofSize: 34, weight: .semibold).fontDescriptor.withDesign(.rounded)!, size: 34),
            ]
        }
    }
}

struct TabBarKids: View {
    var body: some View {
        TabView {
            Learn()
                .tabItem {
                    Image(systemName: "house")
                    Text("Learn")
                }
                .tag(0)
            
            Activities()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Activities")
                }
                .tag(1)
            
            Profile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)
        }
        .tint(.purple)
    }
}


