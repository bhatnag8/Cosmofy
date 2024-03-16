//
//  ChartView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/14/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State private var isTapped = true
    var planet: Planet
    var body: some View {
        
        HStack {
            Text("Densities compared to \(planet.name)")
                .font(Font.custom("SF Pro Rounded Medium", size: 20))
            Spacer()
        }

        
        Chart(planet.data) { dataPoint in
            let color: Color = isTapped ? dataPoint.original : dataPoint.color
            BarMark(x: .value("Escape Velocity", dataPoint.count),
                    y: .value("Planet", dataPoint.type))
            .foregroundStyle(color)
            .annotation(position: .trailing) {
                Text(String(dataPoint.count))
                    .foregroundColor(color)
                    .font(Font.custom("SF Pro Rounded Regular", size: 16))
            }
        }
        .onTapGesture {
            Haptics.shared.impact(for: .medium)
            isTapped.toggle()
        }
        .chartLegend(.hidden)
        .chartYAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .font(Font.custom("SF Pro Rounded Medium", size: 12))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        
        VStack(spacing: 2) {
            HStack {
                Text("Rocky planets are denser due to solid compositions.")
                    .font(Font.custom("SF Pro Rounded Regular", size: 12))
                    .foregroundStyle(.secondary)
                Spacer()
            }
            HStack {
                Text("Gas giants have lower densities owing to gaseous atmospheres.")
                    .font(Font.custom("SF Pro Rounded Regular", size: 12))
                    .foregroundStyle(.secondary)

                Spacer()
            }
            HStack {
                Text("Ice giants are closer to 1.0, the density of water.")
                    .font(Font.custom("SF Pro Rounded Regular", size: 12))
                    .foregroundStyle(.secondary)

                Spacer()
            }
        }
    }
    
}




#Preview {
    ChartView(planet: neptunePlanet)
}
