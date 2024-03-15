//
//  ChartView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/14/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State private var isTapped = false
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
    }
}




#Preview {
    ChartView(planet: neptunePlanet)
}
