//
//  RNNMaybach.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 5/7/24.
//

import SwiftUI
import MapKit
import WeatherKit
import CoreLocation

var fetchedEvents = [Event]()
var fetchedErrorMessage: String?

struct RNNMaybach: View {
    @State private var showSheet: Bool = false
    @State private var events = [Event]()
    @State private var errorMessage: String?
    @State private var coors = [CLLocationCoordinate2D]()
    @Binding var isLoading: Bool
    @State private var selectedResult: Event?
    @State private var showDetails: Bool = false
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Loading events...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else if errorMessage != nil {
                Text(errorMessage ?? "Unknown error")
                    .padding()
                    .foregroundColor(.red)
            } else {
                Map(selection: $selectedResult) {
                    ForEach(events, id: \.self) { event in
                        Marker("\(event.title)", systemImage: markerImage(for: event.categories.first?.id ?? "default"),
                               coordinate: CLLocationCoordinate2D(
                                latitude: event.geometry.last?.coordinates.last ?? -999,
                                longitude: event.geometry.last?.coordinates.first ?? -999)
                        )
                        .tint(markerTint(for: event.categories.first?.id ?? "default"))
                    }
                }
//                .padding(.vertical, -100)
//                .clipped()
                .sheet(isPresented: $showDetails) {
                    ScrollView(.vertical, content: {
                        VStack(alignment: .leading, spacing: 15, content: {
                            MapDetails(event: selectedResult, visible: $showDetails)
                                .presentationDetents([.height(300)])
                                .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                                .presentationCornerRadius(24)
                        })
                        .padding()
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .presentationDetents([.height(300), .medium, .large])
                    .presentationCornerRadius(24)
                    .presentationBackground(.regularMaterial)
                    .presentationBackgroundInteraction(.enabled(upThrough: .large))
//                    .interactiveDismissDisabled()
                    .bottomMaskForSheet(mask: false)
                }
                .mapStyle(.standard(elevation: .realistic))
                .onAppear {
                    self.events = fetchedEvents
                    self.errorMessage = fetchedErrorMessage
                }
                .alert(isPresented: .constant(fetchedErrorMessage != nil), content: {
                    Alert(title: Text("Error"), message: Text(fetchedErrorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                })
            }
        }
        .onChange(of: selectedResult) { oldValue, newValue in
            showDetails = newValue != nil
        }
    }
    

}

#Preview {
//    RNNMaybach(isLoading: .constant(true))
    TabBarView()
//    MapDetails(event: sampleEvent)
}

let sampleEvent = Event(
    id: "EONET_6518",
    title: "Tropical Cyclone Ialy",
    description: nil,
    link: URL(string: "https://eonet.gsfc.nasa.gov/api/v3/events/EONET_6518")!,
    closed: nil,
    categories: [Event.Category(id: "severeStorms", title: "Severe Storms")],
    sources: [Event.Source(id: "JTWC", url: URL(string: "https://www.metoc.navy.mil/jtwc/products/sh2424.tcw")!)],
    geometry: [
        Event.Geometry(magnitudeValue: 35.0, magnitudeUnit: "kts", date: "2024-05-16T06:00:00Z", type: "Point", coordinates: [52.9, -8.6]),
        Event.Geometry(magnitudeValue: 40.0, magnitudeUnit: "kts", date: "2024-05-16T12:00:00Z", type: "Point", coordinates: [52.5, -9.1])
        // Add more geometries as needed
    ]
)

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    private let weatherService = WeatherService.shared
    
    func fetchWeather(latitude: Double, longitude: Double) {
        Task {
            do {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                let weather = try await weatherService.weather(for: location)
                DispatchQueue.main.async {
                    self.weather = weather
                }
            } catch {
                print("Error fetching weather: \(error)")
            }
        }
    }
}
struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    var latitude: Double
    var longitude: Double
    
    var body: some View {
        VStack {
            if let weather = viewModel.weather {
                HStack {
                    Text(String(format: "%.1f", weather.currentWeather.temperature.value) + " \(weather.currentWeather.temperature.unit.symbol)")
                        .font(Font.custom("SF Pro Rounded Medium", size: 18))
                }
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .onAppear {
                        viewModel.fetchWeather(latitude: latitude, longitude: longitude)
                    }
            }
        }
    }
}


@ViewBuilder
func MapDetails(event: Event?, visible: Binding<Bool>) -> some View {
    
    @State var weather: Weather?
    @State var error: Error?
    
    VStack(spacing: 16) {
        if let event = event {
            VStack() {
                HStack {
                    Text(event.title)
                        .font(Font.custom("SF Pro Rounded Semibold", size: 22))
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .background(.ultraThinMaterial)
                        .onTapGesture {
                            visible.wrappedValue = false
                        }
                }
                
                ForEach(event.categories) { category in
                    HStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(Color(markerTint(for: category.id)).gradient)
                            Image(systemName: markerImage(for: category.id))
                        }
                        .foregroundStyle(markerTint(for: category.id) == .white ? .black : .white)
                        .frame(maxHeight: 35)
                        Text(category.title)
                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                        Spacer()
                        if category == event.categories.first {
                            let firstCoordinate = event.geometry.first?.coordinates
                            if let firstCoordinate = firstCoordinate {
                                let latitude = firstCoordinate[1]
                                let longitude = firstCoordinate[0]
                                WeatherView(latitude: latitude, longitude: longitude)
                            }
                        }
                    }
                }
                
                VStack(spacing: 4) {
                    HStack {
                        Text("First Record")
                            .font(Font.custom("SF Pro Rounded Regular", size: 15))
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    HStack {
                        Text(formattedDate(from: event.geometry.first?.date ?? ""))
                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                        Spacer()
                    }
                }
                .padding(.top, 6)

                
                VStack(spacing: 4) {
                    HStack {
                        Text("Latest Record")
                            .font(Font.custom("SF Pro Rounded Regular", size: 15))
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    HStack {
                        Text(formattedDate(from: event.geometry.last?.date ?? ""))
                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                        Spacer()
                    }
                }
                .padding(.vertical, 6)
                
                Map(coordinateSpan) {
                    ForEach(event.geometry) { geo in
                        Annotation(coordinate: CLLocationCoordinate2D(
                            latitude: geo.coordinates[1],
                            longitude: geo.coordinates[0]), content: {
                                Circle()
                                    .foregroundStyle(.yellow)
                                    .frame(width: 10, height: 10)
                            }) {
                               
                            }
                    }
                }
                
                .frame(height: 256)
                .mapStyle(.hybrid(showsTraffic: false))
                
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: event.geometry.first?.coordinates[1] ?? 0,
                        longitude: event.geometry.first?.coordinates[0] ?? 0),
                    span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))),
                    annotationItems: event.geometry) { geom in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(
                        latitude: geom.coordinates[1],
                        longitude: geom.coordinates[0])) {
                        Circle()
                            .strokeBorder(Color.blue, lineWidth: 2)
                            .frame(width: 10, height: 10)
                    }
                }
                .frame(height: 300)
            }
            .padding(.vertical)
        } else {
            Text("No event data available")
        }
    }
}


private func markerImage(for title: String) -> String {
    switch title.lowercased() {
    case "drought":
        return "drop.circle"
    case "dusthaze":
        return "sun.haze"
    case "earthquakes":
        return "waveform.path.ecg"
    case "floods":
        return "cloud.rain"
    case "landslides":
        return "arrowtriangle.down.circle"
    case "manmade":
        return "hammer"
    case "sealakeice":
        return "snowflake"
    case "severestorms":
        return "cloud.bolt.rain"
    case "snow":
        return "snowflake"
    case "tempextremes":
        return "thermometer.snowflake"
    case "volcanoes":
        return "mountain.2"
    case "watercolor":
        return "drop.triangle.fill"
    case "wildfires":
        return "flame"
    default:
        return "mappin.circle"
    }
}

private func markerTint(for title: String) -> Color {
    switch title.lowercased() {
    case "drought":
        return .yellow
    case "dusthaze":
        return .green
    case "earthquakes":
        return .gray
    case "floods":
        return .blue
    case "landslides":
        return .orange
    case "manmade":
        return .SOUR
    case "sealakeice":
        return .white
    case "severestorms":
        return .mint
    case "snow":
        return .white
    case "tempextremes":
        return .miamiBlue
    case "volcanoes":
        return .red
    case "watercolor":
        return .black
    case "wildfires":
        return .orange
    default:
        return .yellow
    }
}

extension View {
    @ViewBuilder
    /// Default Tab Bar height = 49.
    func bottomMaskForSheet(mask: Bool = true, _ height: CGFloat = 49) -> some View {
        self
            .background(SheetRootViewFinder(mask: mask, height: height))
    }
}

/// Helpers
fileprivate struct SheetRootViewFinder: UIViewRepresentable {
    var mask: Bool
    var height: CGFloat
    func makeUIView(context: Context) -> UIView {
        return .init()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let rootView = uiView.viewBeforeWindow, let window = rootView.window {
                let safeArea = window.safeAreaInsets
                /// Updating it's Height So that it will create a empty space in the bottom
                rootView.frame = .init(
                    origin: .zero,
                    size: .init(
                        width: window.frame.width,
                        height: window.frame.height - (mask ? (height + safeArea.bottom) : 0)
                    )
                )
                
                rootView.clipsToBounds = true
                for view in rootView.subviews {
                    /// Removing Shadows
                    view.layer.shadowColor = UIColor.clear.cgColor
                    
                    if view.layer.animationKeys() != nil {
                        if let cornerRadiusView = view.allSubViews.first(where: { $0.layer.animationKeys()?.contains("cornerRadius") ?? false }) {
                            cornerRadiusView.layer.maskedCorners = []
                        }
                    }
                }
            }
        }
    }
}

fileprivate extension UIView {
    var viewBeforeWindow: UIView? {
        if let superview, superview is UIWindow {
            return self
        }
        
        return superview?.viewBeforeWindow
    }
    
    /// Retreiving All Subviews from an UIView
    var allSubViews: [UIView] {
        return subviews.flatMap { [$0] + $0.subviews }
    }
}

func formattedDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .long
        outputFormatter.timeStyle = .short
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
