//
//  CosmofyApp.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import Foundation
import SwiftUI

@main
struct CosmofyApp: App {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault

    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .preferredColorScheme(userTheme.colorScheme)

        }
    }
}


struct SplashScreen: View {
    @StateObject var viewModel = ViewModelAPOD()

    @State private var showSplash = true
    @AppStorage("selectedProfile") var currentSelectedProfile: Int?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false

    
    @State private var fetchComplete = false
    @State private var fetchFailed = false

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .onAppear {
//                        currentUserSignedIn = false
                        viewModel.fetch()
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
                                print(fetchedErrorMessage ?? "fetchedErrorMessage")
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                                print(currentSelectedProfile ?? "currentSelectedProfile")
                            }
                        }
                    }
            } else {
                IntroView(viewModel: viewModel, fetchComplete: $fetchComplete, fetchFailed: $fetchFailed)
            }
        }
    }
}

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: 0xD2DFF7),
                    Color(hex: 0xE1E8F4),
                    Color(hex: 0xC8D5F1),
                    Color(hex: 0xB7C5F4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            Image("app-icon-4k")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
