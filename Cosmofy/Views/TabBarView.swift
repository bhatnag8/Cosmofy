//
//  TabBarView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", image: "tab-bar-home")
                }
            
            Planets()
                .tabItem {
                    Label("Planets", image: "tab-bar-planets")
                }
            
            Text("Swift")
                .tabItem {
                    Label("Swift", image: "tab-bar-swift")
                }
        
            Text("Roadmap")
                .tabItem {
                    Label("Roadmap", image: "tab-bar-roadmap")
                }
            
        }
        .tint(.primary)
    }
}

#Preview {
    TabBarView()
}
