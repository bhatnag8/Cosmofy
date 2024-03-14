//
//  ChartView.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/13/24.
//

import SwiftUI
import Charts

struct PlanetChart: View {
    
    let data: [LocationData.Series]
    @Environment(\.calendar) var calendar
    @Binding var rawSelectedDate: Date?
    @Environment(\.colorScheme) var colorScheme
    
    func endOfDay(for date: Date) -> Date {
        calendar.date(byAdding: .day, value: 1, to: date)!
    }
    
    var selectedDate: Date? {
        if let rawSelectedDate {
            return data.first?.sales.first(where: {
                let endOfDay = endOfDay(for: $0.day)
                
                return ($0.day ... endOfDay).contains(rawSelectedDate)
            })?.day
        }
        
        return nil
    }
    
    struct SaleCountPerCity: Identifiable {
        var city: String
        var count: Int
        var id: String { city }
    }

    func salesPerCity(on selectedDate: Date) -> [SaleCountPerCity]? {
        guard let index = data[0].sales.firstIndex(where: { day, sales in
            calendar.isDate(day, equalTo: selectedDate, toGranularity: .weekday)
        }) else {
            return nil
        }
        return data.map {
            SaleCountPerCity(city: $0.city, count: $0.sales[index].sales)
        }
    }
    
    let colorPerCity: [String: Color] = [
        "San Francisco": .purple,
        "Cupertino": .green
    ]
    
    
    var body: some View {
        Chart {
            ForEach(data) { series in
                ForEach(series.sales, id: \.day) { element in
                    LineMark(
                        x: .value("Day", element.day, unit: .day),
                        y: .value("Sales", element.sales)
                    )
                }
                .foregroundStyle(by: .value("City", series.city))
                .symbol(by: .value("City", series.city))
                .interpolationMethod(.catmullRom)
            }
            
            if let selectedDate {
                RuleMark(
                    x: .value("Selected", selectedDate, unit: .day)
                )
                .foregroundStyle(Color.gray.opacity(0.3))
                .offset(yStart: -10)
                .zIndex(-1)
                .annotation(
                    position: .top, spacing: 0,
                    overflowResolution: .init(
                        x: .fit(to: .chart),
                        y: .disabled
                    )
                ) {
                    valueSelectionPopover
                }
            }
        }
        .chartForegroundStyleScale { colorPerCity[$0]! }
        .chartSymbolScale([
            "San Francisco": Circle().strokeBorder(lineWidth: 2),
            "Cupertino": Square().strokeBorder(lineWidth: 2)
        ])
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
            }
        }
        .chartLegend(.hidden)
        .chartXSelection(value: $rawSelectedDate)
    }
    
    @ViewBuilder
    var valueSelectionPopover: some View {
        if let selectedDate,
           let salesPerCity = salesPerCity(on: selectedDate) {
            VStack(alignment: .leading) {
                Text("Average on \(selectedDate, format: .dateTime.weekday(.wide))s")
                    .font(preTitleFont)
                    .foregroundStyle(.secondary)
                    .fixedSize()
                HStack(spacing: 20) {
                    ForEach(salesPerCity) { salesInfo in
                        VStack(alignment: .leading, spacing: 1) {
                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                Text("\(salesInfo.count, format: .number)")
                                    .font(titleFont)
                                    .foregroundColor(colorPerCity[salesInfo.city])
                                    .blendMode(colorScheme == .light ? .plusDarker : .normal)
                                
                                    Text("sales")
                                        .font(preTitleFont)
                                        .foregroundStyle(.secondary)
                            }
                            HStack(spacing: 6) {
                                if salesInfo.city == "San Francisco" {
                                    legendCircle
                                } else {
                                    legendSquare
                                }
                                Text("\(salesInfo.city)")
                                    .font(labelFont)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(Color.gray.opacity(0.12))
            }
        } else {
            EmptyView()
        }
    }
    
}


struct ChartView: View {
    @State var rawSelectedDate: Date? = nil
    @State var rawSelectedRange: ClosedRange<Date>? = nil
    var data: [LocationData.Series] {
        return LocationData.last30Days
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 1) {
                Text("Sundays in San Francisco")
                    .font(Font.custom("SF Pro Rounded Medium", size: 22))
                HStack {
                    HStack(spacing: 5) {
                        legendSquare
                        Text("Cupertino")
                            .font(Font.custom("SF Pro Rounded Regular", size: 12))
                            .foregroundStyle(.secondary)
                    }
                    
                    HStack(spacing: 5) {
                        legendCircle
                        Text("San Francisco")
                            .font(Font.custom("SF Pro Rounded Regular", size: 12))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .opacity(rawSelectedDate == nil && rawSelectedRange == nil ? 1.0 : 0.0)
            
//            Spacer(minLength: 6)
            
            PlanetChart(
                data: data,
                rawSelectedDate: $rawSelectedDate
            )
            .frame(height: 240)
            
            
        }
        
    }
}



@ViewBuilder
var legendSquare: some View {
    RoundedRectangle(cornerRadius: 1)
        .stroke(lineWidth: 2)
        .frame(width: 5.3, height: 5.3)
        .foregroundColor(.green)
        .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
}

@ViewBuilder
var legendCircle: some View {
    Circle()
        .stroke(lineWidth: 2)
        .frame(width: 5.7, height: 5.7)
        .foregroundColor(.purple)
        .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
}

#Preview {
    PlanetView(planet: mercuryPlanet)
}


/// A square symbol for charts.
struct Square: ChartSymbolShape, InsettableShape {
    let inset: CGFloat

    init(inset: CGFloat = 0) {
        self.inset = inset
    }

    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
            cornerRadius: cornerRadius
        )
    }

    func inset(by amount: CGFloat) -> Square {
        Square(inset: inset + amount)
    }

    var perceptualUnitRect: CGRect {
        // The width of the unit rectangle (square). Adjust this to
        // size the diamond symbol so it perceptually matches with
        // the circle.
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
    }
}

#if os(macOS)
var titleFont: Font = .title.bold()
#else
var titleFont: Font = .title2.bold()
#endif

#if os(macOS)
var preTitleFont: Font = .headline
#else
var preTitleFont: Font = .callout
#endif

#if os(macOS)
var labelFont: Font = .subheadline
#else
var labelFont: Font = .caption2
#endif

#if os(macOS)
var descriptionFont: Font = .body
#else
var descriptionFont: Font = .subheadline
#endif
