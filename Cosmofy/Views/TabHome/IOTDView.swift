//
//  IOTD.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/15/24.
//

import SwiftUI

struct IOTDView: View {
    
    @ObservedObject var viewModel = ViewModelAPOD()

    var body: some View {
        NavigationStack {
            
            ScrollView {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .padding()
                        .foregroundStyle(.red)
                } else if let apod = viewModel.apod {
                    VStack {
                        HStack {
                            Text(viewModel.apod!.title)
                                .padding(.vertical, 8)
                                .font(Font.custom("SF Pro Rounded Medium", size: 24))
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)

                        ImageView.init(viewModel.apod!.url)
                            .padding(.horizontal)
                        
                        Text(viewModel.apod!.explanation)
                            .padding()
                            .font(Font.custom("SF Pro Rounded Regular", size: 16))

                        
                        Spacer(minLength: 48)
                        
                        Text("Each day a different image or photograph of our fascinating universe is featured, along with a brief explanation written by a professional astronomer. The information is provided by NASA.")
                            .foregroundStyle(.secondary)
                            .font(Font.custom("SF Pro Rounded Regular", size: 14))
                            .padding()
                    }
                } else {
                    LoadingView(color: .labelColorMod)
                        .frame(width: 50, height: 25)
                        .padding()
                }
            }
            .navigationTitle("Today's Picture")
            .onAppear(perform: viewModel.fetch)
            .onAppear(perform: {Haptics.shared.vibrate(for: .success)})

        }
        .navigationTitle("Today's Picture")

    }
    

}


