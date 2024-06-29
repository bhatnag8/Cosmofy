//
//  iPadHome.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 6/27/24.
//

import SwiftUI

struct iPadHome: View {
    @State private var trigger: Bool = false
    @ObservedObject var viewModel = ViewModelAPOD()
    @State var fetched: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("home-banner-1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                

                HStack {
                    VStack {
                        
                        HStack {
                            Text("Cosmofy for iPad")
                                .padding()
                                .font(Font.custom("SF Pro Rounded Semibold", size: 32))
                            
                            Spacer()
                            GarenText(text: "1.2", trigger: trigger)
                                .font(Font.system(size: 22, weight: .semibold, design: .monospaced))
                                .padding()
                        }
                        .padding(.vertical)
                        
                        VStack {
                            HStack {
                                Text("article of the month")
                                    .textCase(.uppercase)
                                    .foregroundStyle(.secondary)
                                Spacer()

                            }
                            Divider()
                        }
                        .padding(.horizontal)
                        
                        ScrollView {
                            VStack(spacing: 24) {
                                NavigationLink(destination: JulyView()) {
                                    VStack(spacing: 0) {
                                        
                                        ZStack {
                                            Color.black
                                            Image("July Article")
                                                .resizable()
                                                .scaledToFill()

                                        }
                                        .frame(height: 180)
                                            
                                        HStack {
                                            VStack {
                                                Text("07")
                                                    .font(.largeTitle)
                                                    .fontDesign(.serif)
                                                
                                                Text("2024")
                                                    .fontDesign(.serif)
                                                    .foregroundStyle(.secondary)
                                            }
                                            
                                            
                                            VStack() {
                                                HStack {
                                                    Text("Astronomers Reimagine the Making of the Planets")
                                                        .multilineTextAlignment(.leading)
                                                        .font(Font.custom("SF Pro Rounded Regular", size: 18))
                                                        .foregroundColor(.primary)
                                                    Spacer()
                                                }
                                                
                                                HStack {
                                                    Text("Rebecca Boyle")
                                                        .multilineTextAlignment(.leading)
                                                        .italic()
                                                            .fontDesign(.serif)
                                                            .foregroundColor(.secondary)
                                                    Spacer()
                                                }
                                                
                                                
                                            }
                                            .padding(.leading)
                                            
                                            Spacer()
                                            
                                        }
                                        .padding()
                                        .background(Color.BETRAY)
                                    }
                                    .clipShape(RoundedRectangle.init(cornerRadius: 18))
                                    
                                }
                                
                                VStack {
                                    VStack {
                                        HStack {
                                            Text("abstract")
                                                .textCase(.uppercase)
                                                .foregroundStyle(.secondary)
                                            Spacer()
                                        }
                                        Divider()
                                    }
                                    .padding([.top])
                                    
                                    Text("Observations of faraway planets have forced a near-total rewrite of the story of how our solar system came to be.")
                                        .italic()
                                        .fontDesign(.serif)
                                }
                                
                                
                            }
                            .padding()
                        }
                        

                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.80)
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 48))
                    
                    Spacer(minLength: 48)
                    
                    VStack {
                        VStack {
                            HStack {
                                Text("Astronomy Picture of the Day")
                                    .textCase(.uppercase)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            Divider()
                                
                        }
                        .padding(.top, 32)
                        .padding(.horizontal)
                        
                        ScrollView {
                            if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage)
                                    .padding()
                                    .foregroundColor(.red)
                            } else if let apod = viewModel.apod {
                                VStack {
                                    
                                    VStack {
                                        HStack {
                                            Text(apod.title)
                                                .bold()
                                                .fontWidth(.compressed)
                                                .font(.title)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                        HStack {
                                            Text(convertDateString(dateString: apod.date))
                                                .italic()
                                                .fontDesign(.serif)
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                    }
                                    
                                    
                                    if apod.media_type == "image" {
                                        ImageView(apod.url)
                                            .aspectRatio(contentMode: .fit)
                                            .padding()
                                    } else if apod.media_type == "video" {
                                        WebView(urlString: apod.url)
                                            .frame(height: 300)
                                            .padding(.horizontal)
                                    }
                                    VStack {
                                        VStack {
                                            HStack {
                                                Text("a brief explanation")
                                                    .textCase(.uppercase)
                                                    .foregroundStyle(.secondary)
                                                Spacer()
                                            }
                                            Divider()
                                        }
                                        .padding([.top, .horizontal])
                                        
                                        Text(apod.explanation)
                                            .italic()
                                            .fontDesign(.serif)
                                            .padding(.horizontal)
                                    }
                                    
                                }
                            } else {
                                ProgressView("Loading...")
                                    .padding()
                            }
                        }
                        .onAppear {
                            if !fetched {
                                viewModel.fetch()
                                fetched = true
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.80)
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 48))
                    

                }
                .padding(48)
            }
        }
        


    }
}

#Preview {
    iPadHome()
}
