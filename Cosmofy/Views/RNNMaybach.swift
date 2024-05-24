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
    @StateObject private var weatherViewModel = WeatherViewModel() // Initialize here
    
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
                            MapDetails(event: selectedResult, visible: $showDetails, weatherViewModel: weatherViewModel) // Pass here
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
    TabBarView()
}

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

@ViewBuilder
func MapDetails(event: Event?, visible: Binding<Bool>, weatherViewModel: WeatherViewModel) -> some View {
    
    @State var error: Error?
    
    VStack(spacing: 16) {
        if let event = event {
            VStack {
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
                                VStack {
                                    if let weather = weatherViewModel.weather {
                                        HStack {
                                            Text(String(format: "%.1f", weather.currentWeather.temperature.value) + " \(weather.currentWeather.temperature.unit.symbol)")
                                                .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                        }
                                    } else {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                            .onAppear {
                                                weatherViewModel.fetchWeather(latitude: latitude, longitude: longitude)
                                            }
                                    }
                                }
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
                
                if event.geometry.count == 1 {
                    Map(coordinateRegion: .constant(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: ((event.geometry.first?.coordinates[1] ?? 0) + (event.geometry.last?.coordinates[1] ?? 0))/2,
                            longitude: ((event.geometry.first?.coordinates[0] ?? 0) + (event.geometry.last?.coordinates[0] ?? 0))/2),
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))),
                        annotationItems: event.geometry) { geom in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(
                            latitude: geom.coordinates[1],
                            longitude: geom.coordinates[0])) {
                            Circle()
                                .strokeBorder(Color.yellow, lineWidth: 2)
                                .frame(width: 7, height: 7)
                        }
                    }
                    .frame(height: 256)
                    .clipShape(RoundedRectangle(cornerRadius: 15)) // Apply corner radius
                    .mapStyle(.hybrid(showsTraffic: false))
                } else {
                    Map() {
                        ForEach(event.geometry) { geo in
                            Annotation(coordinate: CLLocationCoordinate2D(
                                latitude: geo.coordinates[1],
                                longitude: geo.coordinates[0]), content: {
                                    Circle()
                                        .foregroundStyle(.yellow)
                                        .frame(width: 7, height: 7)
                                }) {
                                   
                                }
                        }
                    }
                    .frame(height: 256)
                    .clipShape(RoundedRectangle(cornerRadius: 15)) // Apply corner radius
                    .mapStyle(.hybrid(showsTraffic: false))
                }
            }
            .padding(.vertical)
            .onChange(of: event) { oldEvent, newEvent in
                if let firstCoordinate = newEvent.geometry.first?.coordinates {
                    let latitude = firstCoordinate[1]
                    let longitude = firstCoordinate[0]
                    weatherViewModel.fetchWeather(latitude: latitude, longitude: longitude)
                }
            }
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
    func bottomMaskForSheet(mask: Bool = true, _ height: CGFloat = 50) -> some View {
        self
            .background(SheetRootViewFinder(mask: mask, height: height))
    }
}

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
                rootView.frame = .init(
                    origin: .zero,
                    size: .init(
                        width: window.frame.width,
                        height: window.frame.height - (mask ? (height + safeArea.bottom) : 0)
                    )
                )
                
                rootView.clipsToBounds = true
                for view in rootView.subviews {
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
