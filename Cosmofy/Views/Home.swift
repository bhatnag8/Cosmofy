//
//  Home.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/9/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        let phrase = currentDayAndTime()
        
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                
                GeometryReader(content: { proxy in
                    let size = proxy.size
                    ScrollView(.horizontal) {
                        HStack(spacing: 10, content: {
                            ForEach(imageList) { card in
                                GeometryReader(content: { geometry in
                                    let cardSize = geometry.size
                                    let minX = min(geometry.frame(in: .scrollView).minX * 1.2, geometry.size.width * 1.2)
                                    Image(card.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .offset(x: -minX)
                                        .frame(width: cardSize.width * 2)
                                        .frame(width: cardSize.width, height: cardSize.height)
                                        .overlay(content: {
                                            OverlayView(card: card)
                                        })
                                        .clipShape(.rect(cornerRadius: 20))
                                        .shadow(color: card.color, radius: 3)
                                })
                                .frame(width: size.width - 60, height: size.height - 50)
                                .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                    view.scaleEffect(phase.isIdentity ? 1 : 0.95)
                                }
                            }
                        })
                        .padding(20)
                        .scrollTargetLayout()
                        .frame(height: size.height, alignment: .top)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                })
                .frame(height: 550)
                .padding(.horizontal, -15)
                
                Divider()
                
                VStack {
                    
                    HStack {
                        Text("Cosmofy")
                            .font(Font.custom("SF Pro Rounded Semibold", size: 32))
                        Spacer()
                        Text("Good \(phrase)")
                            .font(Font.custom("SF Pro Rounded Semibold", size: 18))
                            .foregroundStyle(.green)
                    }

                    HStack {
                        Image("home-icon-1")
                            .resizable()
                            .frame(width: 30, height: 30)

                        Link("Article of the Month", destination: URL(string: "https://www.arryan.xyz/cosmofy/aotm")!)
                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                    
                    HStack {
                        Image("home-icon-2")
                            .resizable()
                            .frame(width: 30, height: 30)
                            
                        
                        Link("Image of the Day", destination: URL(string: "https://www.arryan.xyz/cosmofy/aotm")!)
                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                }
                .padding()
            }
            .padding([.leading, .trailing, .bottom])
        }
    }
    
    @ViewBuilder
    func OverlayView(card: ImageViewCard) -> some View {
        ZStack(alignment: .bottomLeading, content: {
            LinearGradient(colors: [.clear, .clear, .clear, .black.opacity(0.1), .black.opacity(0.5), .black], startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text("\(card.title)")
                    .font(Font.custom("SF Pro Rounded Semibold", size: 24))
                
                Text("\(card.subtitle)")
                    .font(Font.custom("SF Pro Rounded Medium", size: 16))
            })
            .foregroundColor(.white)
            .padding()
        })
    }
    
    func currentDayAndTime() -> String {
            let currentDate = Date()
            let calendar = Calendar.current
            
            let dayOfWeek = calendar.component(.weekday, from: currentDate)
            let hourOfDay = calendar.component(.hour, from: currentDate)
            
            _ = dayOfWeekString(dayOfWeek)
            let timeOfDayString = timeOfDay(hourOfDay)
            
            return "\(timeOfDayString)"
        }
        
        func dayOfWeekString(_ dayOfWeek: Int) -> String {
            let weekdays = ["", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            return weekdays[dayOfWeek]
        }
        
        func timeOfDay(_ hourOfDay: Int) -> String {
            switch hourOfDay {
            case 0..<12:
                return "Morning"
            case 12..<17:
                return "Afternoon"
            case 17..<21:
                return "Evening"
            default:
                return "Night"
            }
        }
    
}




#Preview {
    Home()
}
