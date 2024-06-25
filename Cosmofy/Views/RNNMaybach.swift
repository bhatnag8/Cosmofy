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
import VTabView

var fetchedEvents = [Event]()
var fetchedErrorMessage: String?

struct MapWithEvents: View {
    @State var event: Event?
    @State var selected: Bool = false
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var units = ["°C", "°F"]
    @State private var selectedUnit = "°C"
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(selection: $event) {
                    ForEach(fetchedEvents, id: \.self) { event in
                        Marker("", systemImage: markerImage(for: event.categories.first?.id ?? "default"),
                               coordinate: CLLocationCoordinate2D(
                                latitude: event.geometry.last?.coordinates.last ?? -999,
                                longitude: event.geometry.last?.coordinates.first ?? -999)
                        )
                        .tint(markerTint(for: event.categories.first?.id ?? "default"))
                    }
                }
                .onChange(of: event, {
                    withAnimation {
                        selected = true
                        
                    }
                })
                .mapControls {
                    MapCompass()
                    MapScaleView()
                    MapPitchToggle()
                }
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
                .mapStyle(.standard(elevation: .realistic))
                .alert(isPresented: .constant(fetchedErrorMessage != nil), content: {
                    Alert(title: Text("Error"), message: Text(fetchedErrorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                })
                
                if selected {
                    VStack {
                        
                        Spacer()
                        
                        
                        
                        VTabView(indexPosition: .trailing) {
                            // View 1
                            VStack {
                                HStack {
                                    VStack {
                                        HStack {
                                            Text("Event name")
                                                .font(.caption)
                                                .textCase(.uppercase)
                                                .foregroundStyle(.secondary)
                                            
                                            Spacer()
                                            
                                        }
                                        Divider()
                                    }
                                    .padding(.trailing, 12)
                                    
                                    
                                    Spacer()
                                    
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding(.trailing, 12)
                                        .onTapGesture {
                                            withAnimation {
                                                selected = false
                                            }
                                        }
                                    
                                }
                                
                                
                                
                                
                                HStack {
                                    Text(event?.title ?? "")
                                        .multilineTextAlignment(.leading)
                                        .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    
                                    Spacer()
                                }
                                .padding(.trailing, 36)
                                
                                if event != nil {
                                    ForEach(event?.categories ?? []) { category in
                                        HStack(spacing: 8) {
                                            ZStack {
                                                Circle().fill(Color(markerTint(for: category.id)).gradient)
                                                Image(systemName: markerImage(for: category.id))
                                            }
                                            .foregroundStyle(markerTint(for: category.id) == .white ? .black : .white)
                                            .frame(maxHeight: 35)
                                            
                                            VStack(spacing: 0) {
                                                HStack {
                                                    Text(category.title)
                                                        .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    Spacer()
                                                }
                                                
                                                HStack {
                                                    Text("Event Category")
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                    Spacer()
                                                }
                                                
                                            }
                                            
                                            
                                            Spacer()
                                        }
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Text("Weather")
                                                .font(Font.custom("SF Pro Rounded Medium", size: 16))
                                            
                                            Spacer()
                                            
                                            if category == event?.categories.first {
                                                let firstCoordinate = event?.geometry.first?.coordinates
                                                if let firstCoordinate = firstCoordinate {
                                                    let latitude = firstCoordinate[1]
                                                    let longitude = firstCoordinate[0]
                                                    if let weather = weatherViewModel.weather {
                                                        HStack(spacing: 2) {
                                                            Image(systemName: weather.currentWeather.symbolName)
                                                            Text(String(format: "%.1f", weather.currentWeather.temperature.value) + " \(weather.currentWeather.temperature.unit.symbol)")
                                                                .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                        }
                                                        .onAppear {
                                                            weatherViewModel.fetchWeather(latitude: latitude, longitude: longitude)
                                                        }
                                                        .onChange(of: firstCoordinate, {
                                                            weatherViewModel.fetchWeather(latitude: latitude, longitude: longitude)
                                                        })
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
                                
                                
                                
                                
                                
                            }
                            
                            
                            // View 2
                            VStack {
                                if event?.geometry.count == 1 {
                                    Map(coordinateRegion: .constant(MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(
                                            latitude: ((event?.geometry.first?.coordinates[1] ?? 0) + (event?.geometry.last?.coordinates[1] ?? 0))/2,
                                            longitude: ((event?.geometry.first?.coordinates[0] ?? 0) + (event?.geometry.last?.coordinates[0] ?? 0))/2),
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))),
                                        interactionModes: [], annotationItems: event?.geometry ?? []) { geom in
                                        MapAnnotation(coordinate: CLLocationCoordinate2D(
                                            latitude: geom.coordinates[1],
                                            longitude: geom.coordinates[0])) {
                                                Circle()
                                                    .strokeBorder(Color.yellow, lineWidth: 2)
                                                    .frame(width: 7, height: 7)
                                            }
                                    }
                                        .frame(height: 168)
                                    //                                    .clipShape(RoundedRectangle(cornerRadius: 8)) // Apply corner radius
                                        .mapStyle(.hybrid(showsTraffic: false))
                                } else {
                                    Map(interactionModes: []) {
                                        ForEach(event?.geometry ?? []) { geo in
                                            Annotation(coordinate: CLLocationCoordinate2D(
                                                latitude: geo.coordinates[1],
                                                longitude: geo.coordinates[0]), content: {
                                                    Circle()
                                                        .foregroundStyle(.red)
                                                        .frame(width: 6, height: 6)
                                                }) {
                                                    
                                                }
                                        }
                                    }
                                    
                                    .frame(height: 168)
                                    .mapStyle(.hybrid(showsTraffic: false))
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12)) // Apply corner radius
                            
                            
                            // View 3
                            VStack {
                                VStack(spacing: 4) {
                                    HStack {
                                        Text("First Record")
                                            .font(Font.custom("SF Pro Rounded Regular", size: 15))
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                    HStack {
                                        Text(formattedDate(from: event?.geometry.first?.date ?? ""))
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
                                        Text(formattedDate(from: event?.geometry.last?.date ?? ""))
                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                        Spacer()
                                    }
                                }
                                .padding(.vertical, 6)
                            }
                            
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .padding()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                    
                } else {
                    
                }
                
                
            }
        }
        
    }
}



struct RNNMaybach: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("from the NASA Earth Observatory")
                            .font(Font.system(size: 16))
                            .textCase(.uppercase)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    Divider()
                    
                    VStack {
                        HStack {
                            Text("Browse the Entire Globe Daily and Look For Natural Events as They Occur")
                                .textCase(.uppercase)
                                .font(Font.system(size: 42))
                                .bold()
                                .fontWidth(.compressed)
                            Spacer()
                        }
                    }
                    
                    HStack {
                        Text("Displaying All Events since \(getFormattedDate14DaysAgo())")
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.secondary)
                            .fontDesign(.serif)
                            .italic()
                        Spacer()
                    }
                    .padding(.top, 2)
                    .padding(.bottom, 8)
                    
                    NavigationLink(destination: MapWithEvents()) {
                        
                        HStack {
                            Text("Enter Nature Scope")
                                .frame(maxWidth: .infinity)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                        }
                        .padding()
                        .background(Color.green.cornerRadius(8))
                        
                    }
                    
                    HStack {
                        Text("Current categories")
                            .font(Font.system(size: 16))
                            .textCase(.uppercase)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding(.top)
                    Divider()
                    
                    ForEach(categories) { category in
                        VStack {
                            HStack {
                                Text(category.id)
                                    .font(.largeTitle)
                                    .fontDesign(.serif)
                                    .frame(width: 45)
                                VStack {
                                    HStack {
                                        Text(category.title)
                                            .font(Font.custom("SF Pro Rounded Medium", size: 20))
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text(category.description)
                                            .multilineTextAlignment(.leading)
                                            .foregroundStyle(.secondary)
                                            .fontDesign(.serif)
                                            .italic()
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 8)
                        
                        
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("‎‎‏‏‎Nature Scope")
            .onAppear(perform: {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                ]
            })
        }
        
    }
}


#Preview {
    RNNMaybach()
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
                        VStack {
                            HStack {
                                Text(category.title)
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                Spacer()
                            }
                            
                            HStack {
                                Text("Event Category")
                                    .font(Font.custom("SF Pro Rounded Regular", size: 12))
                                Spacer()
                            }
                            
                        }
                        
                        
                        Spacer()
                        if category == event.categories.first {
                            let firstCoordinate = event.geometry.first?.coordinates
                            if let firstCoordinate = firstCoordinate {
                                let latitude = firstCoordinate[1]
                                let longitude = firstCoordinate[0]
                                VStack {
                                    if let weather = weatherViewModel.weather {
                                        VStack {
                                            Text(String(format: "%.1f", weather.currentWeather.temperature.value) + " \(weather.currentWeather.temperature.unit.symbol)")
                                                .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                            Text("Weather")
                                                .font(Font.custom("SF Pro Rounded Regular", size: 12))
                                        }
                                        .onAppear {
                                            weatherViewModel.fetchWeather(latitude: latitude, longitude: longitude)
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
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15)) // Apply corner radius
                        .mapStyle(.hybrid(showsTraffic: false))
                } else {
                    Map() {
                        ForEach(event.geometry) { geo in
                            Annotation(coordinate: CLLocationCoordinate2D(
                                latitude: geo.coordinates[1],
                                longitude: geo.coordinates[0]), content: {
                                    Circle()
                                        .foregroundStyle(.red)
                                        .frame(width: 6, height: 6)
                                }) {
                                    
                                }
                        }
                    }
                    .frame(height: 190)
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

func getFormattedDate14DaysAgo() -> String {
    // Get the current date
    let currentDate = Date()
    
    // Subtract 14 days from the current date
    guard let date14DaysAgo = Calendar.current.date(byAdding: .day, value: -13, to: currentDate) else {
        return "Date calculation error"
    }
    
    // Format the date as "MMMM d"
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d"
    
    return dateFormatter.string(from: date14DaysAgo)
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

struct Category: Identifiable {
    var id: String
    var title: String
    var description: String
}

let categories: [Category] = [
    Category(id: "1", title: "Drought", description: "Long lasting absence of precipitation affecting agriculture and livestock, and the overall availability of food and water."),
    Category(id: "2", title: "Dust and Haze", description: "Related to dust storms, air pollution and other non-volcanic aerosols. Volcano-related plumes shall be included with the originating eruption event."),
    Category(id: "3", title: "Earthquakes", description: "Related to all manner of shaking and displacement. Certain aftermath of earthquakes may also be found under landslides and floods."),
    Category(id: "4", title: "Floods", description: "Related to aspects of actual flooding--e.g., inundation, water extending beyond river and lake extents."),
    Category(id: "5", title: "Landslides", description: "Related to landslides and variations thereof: mudslides, avalanche."),
    Category(id: "6", title: "Manmade", description: "Events that have been human-induced and are extreme in their extent."),
    Category(id: "7", title: "Sea and Lake Ice", description: "Related to all ice that resides on oceans and lakes, including sea and lake ice (permanent and seasonal) and icebergs."),
    Category(id: "8", title: "Severe Storms", description: "Related to the atmospheric aspect of storms (hurricanes, cyclones, tornadoes, etc.). Results of storms may be included under floods, landslides, etc."),
    Category(id: "9", title: "Snow", description: "Related to snow events, particularly extreme/anomalous snowfall in either timing or extent/depth."),
    Category(id: "10", title: "Temperature Extremes", description: "Related to anomalous land temperatures, either heat or cold."),
    Category(id: "11", title: "Volcanoes", description: "Related to both the physical effects of an eruption (rock, ash, lava) and the atmospheric (ash and gas plumes)."),
    Category(id: "12", title: "Water Color", description: "Related to events that alter the appearance of water: phytoplankton, red tide, algae, sediment, whiting, etc."),
    Category(id: "13", title: "Wildfires", description: "Wildfires includes all nature of fire, including forest and plains fires, as well as urban and industrial fire events. Fires may be naturally caused or manmade.")
]
