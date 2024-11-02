//
//  TabBarView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject var viewModel: ViewModelAPOD
    
    @Binding var fetchComplete: Bool
    @Binding var fetchFailed: Bool

    var body: some View {
            TabView {
                            
                if UIDevice.current.userInterfaceIdiom == .phone {
                    Home(viewModel: viewModel, complete: $fetchComplete, failed: $fetchFailed)
                        .tabItem {
                            Label("Home", image: "tab-bar-home")
                        }
                    
                    PlanetsView(complete: $fetchComplete, failed: $fetchFailed)
                        .tabItem {
                            Label("Planets", image: "tab-bar-planets")
                        }
                    
                    SwiftView()
                        .tabItem {
                            Label("Swift", image: "tab-bar-swift")
                        }
                    
                    Profile()
                        .tabItem {
                            Label("Profile", image: "tab-bar-profile")
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
                    
                    SwiftView()
                        .tabItem {
                            Label("Swift", image: "tab-bar-swift")
                        }
                    
                    RNNMaybach(complete: $fetchComplete, failed: $fetchFailed)
                        .tabItem {
                            Label("Nature Scope", image: "tab-bar-naturescope")
                        }
                    
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
    @ObservedObject var viewModel: ViewModelAPOD

    var body: some View {
        TabView {
            Learn(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Learn")
                }
                .tag(0)
            
            Profile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(1)
        }
        .tint(.primary)
 
    }
}


