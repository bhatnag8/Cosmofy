//
//  ChartView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/14/24.
//

import SwiftUI
import Charts

struct StandardChartView: View {
    
    @State private var planets: [Planet] = allPlanets
    @State private var isAnimated: Bool = false
    var body: some View {
        VStack {
            Chart {
                ForEach(planets) { planet in
                    BarMark(
                        x: .value("Density", planet.isAnimated ? planet.gravity : 0),
                        y: .value("Planet", planet.name)
                    )
                    .foregroundStyle(planet.color)
                }
            }
            .chartLegend(.hidden)
            .chartXScale(domain: 0...28)
            .frame(height: 400)
        }
        .onAppear(perform: animateChart)
    }
    
    // MARK: Animating Chart
    private func animateChart() {
        guard !isAnimated else { return }
        isAnimated = true
        
        $planets.enumerated().forEach { index, element in
            let delay = Double(index) * 0.025
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.smooth) {
                    element.wrappedValue.isAnimated = true
                }
            }
        }
    }
}

struct Chart1: View {
    
    @State private var planets: [Planet] = allPlanets
    @State private var isAnimated: Bool = false
    var body: some View {
        VStack {
            Chart {
                ForEach(planets) { planet in
                    PointMark(
                        x: .value("Moons", planet.moons),
                        y: .value("Rings", planet.isAnimated ? planet.rings : 0)
                    )
                    .foregroundStyle(planet.color)
                }
            }
            .chartLegend(.visible)
            .chartYScale(domain: 0...15)
            .frame(height: 200)
            .chartXAxisLabel(LocalizedStringKey("Planetery Moons"))
            .chartYAxisLabel(LocalizedStringKey("Planetery Rings"))
            .font(.caption2)
        }
        .onAppear(perform: animateChart)
    }
    
    // MARK: Animating Chart
    private func animateChart() {
        guard !isAnimated else { return }
        isAnimated = true
        
        $planets.enumerated().forEach { index, element in
            let delay = Double(index) * 0.025
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(.smooth) {
                    element.wrappedValue.isAnimated = true
                }
            }
        }
    }
}

#Preview {
    Chart1()
}


/*
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
 */
