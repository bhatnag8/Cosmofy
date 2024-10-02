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
    
    @Binding var fetchComplete: Bool
    @Binding var fetchFailed: Bool

    var tranition: AnyTransition = .opacity
    
    var body: some View {
        VStack {
            if currentUserSignedIn {
                switch currentSelectedProfile {
                case 1: 
                    TabBarKids(viewModel: viewModel)
                        .transition(tranition)
                case 2:
                    TabBarView(viewModel: viewModel, fetchComplete: $fetchComplete, fetchFailed: $fetchFailed)
                        .transition(tranition)
                default:
                    TabBarView(viewModel: viewModel, fetchComplete: $fetchComplete, fetchFailed: $fetchFailed)
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
