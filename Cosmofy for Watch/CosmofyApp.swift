//
//  WatchCosmofyApp.swift
//  WatchCosmofy Watch App
//
//  Created by Arryan Bhatnagar on 6/15/24.
//

import SwiftUI

@main
struct CosmofyApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}

struct TabBarView: View {
    
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
