//
//  RotationData.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 3/13/24.
//

import Foundation
import SwiftUI
import GameplayKit

private let gaussianRandoms = GKGaussianDistribution(lowestValue: 0, highestValue: 20)

func date(year: Int, month: Int, day: Int = 1) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}

/// Data for the sales by location and weekday charts.
struct LocationData {
    /// A data series for the lines.
    struct Series: Identifiable {
        /// The name of the planet.
        let city: String

        /// Average daily sales for each weekday.
        /// The `weekday` property is a `Date` that represents a weekday.
        let sales: [(day: Date, sales: Int)]

        /// The identifier for the series.
        var id: String { city }
    }

    /// Sales by location and weekday for the last 30 days.
    static let last30Days: [Series] = [
        .init(city: "Cupertino", sales: [
            (day: date(year: 2022, month: 5, day: 2), sales: 54),
            (day: date(year: 2022, month: 5, day: 3), sales: 42),
            (day: date(year: 2022, month: 5, day: 4), sales: 88),
            (day: date(year: 2022, month: 5, day: 5), sales: 49),
            (day: date(year: 2022, month: 5, day: 6), sales: 42),
            (day: date(year: 2022, month: 5, day: 7), sales: 125),
            (day: date(year: 2022, month: 5, day: 8), sales: 67)

        ]),
        .init(city: "San Francisco", sales: [
            (day: date(year: 2022, month: 5, day: 2), sales: 81),
            (day: date(year: 2022, month: 5, day: 3), sales: 90),
            (day: date(year: 2022, month: 5, day: 4), sales: 52),
            (day: date(year: 2022, month: 5, day: 5), sales: 72),
            (day: date(year: 2022, month: 5, day: 6), sales: 84),
            (day: date(year: 2022, month: 5, day: 7), sales: 84),
            (day: date(year: 2022, month: 5, day: 8), sales: 137)
        ])
    ]

    /// The best weekday and location for the last 30 days.
    static let last30DaysBest = (
        city: "San Francisco",
        weekday: date(year: 2022, month: 5, day: 8),
        sales: 137
    )

    /// The best weekday and location for the last 12 months.
    static let last12MonthsBest = (
        city: "San Francisco",
        weekday: date(year: 2022, month: 5, day: 8),
        sales: 113
    )

    /// Sales by location and weekday for the last 12 months.
    static let last12Months: [Series] = [
        .init(city: "Cupertino", sales: [
            (day: date(year: 2022, month: 5, day: 2), sales: 64),
            (day: date(year: 2022, month: 5, day: 3), sales: 60),
            (day: date(year: 2022, month: 5, day: 4), sales: 47),
            (day: date(year: 2022, month: 5, day: 5), sales: 55),
            (day: date(year: 2022, month: 5, day: 6), sales: 55),
            (day: date(year: 2022, month: 5, day: 7), sales: 105),
            (day: date(year: 2022, month: 5, day: 8), sales: 67)
        ]),
        .init(city: "San Francisco", sales: [
            (day: date(year: 2022, month: 5, day: 2), sales: 57),
            (day: date(year: 2022, month: 5, day: 3), sales: 56),
            (day: date(year: 2022, month: 5, day: 4), sales: 66),
            (day: date(year: 2022, month: 5, day: 5), sales: 61),
            (day: date(year: 2022, month: 5, day: 6), sales: 60),
            (day: date(year: 2022, month: 5, day: 7), sales: 77),
            (day: date(year: 2022, month: 5, day: 8), sales: 113)
        ])
    ]
}
