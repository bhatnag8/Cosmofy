//
//  IntroView.swift
//  Cosmofy iOS
//
//  Created by Arryan Bhatnagar on 7/29/24.
//

import SwiftUI

struct IntroView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @AppStorage("selectedProfile") var currentSelectedProfile: Int?
    @ObservedObject var viewModel: ViewModelAPOD
    @ObservedObject var astroService: AstroService
    
    @Binding var fetchComplete: Bool
    @Binding var fetchFailed: Bool

    var tranition: AnyTransition = .opacity
    
    var body: some View {
        VStack {
            if currentUserSignedIn {
                switch currentSelectedProfile {
                case 1: /* Kids Profile */
                    TabBarKids()
                        .transition(tranition)
                case 2:
                    TabBarView(viewModel: viewModel, astroService: astroService, fetchComplete: $fetchComplete, fetchFailed: $fetchFailed)
                        .transition(tranition)
                case 3:
                    TabBarView(viewModel: viewModel, astroService: astroService, fetchComplete: $fetchComplete, fetchFailed: $fetchFailed)
                        .transition(tranition)
                default:
                    TabBarView(viewModel: viewModel, astroService: astroService, fetchComplete: $fetchComplete, fetchFailed: $fetchFailed)
                        .transition(tranition)
                }
            } else {
                OnboardingView()
                    .transition(tranition)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: currentUserSignedIn)
        .animation(.easeInOut(duration: 0.5), value: currentSelectedProfile)
    }
}
