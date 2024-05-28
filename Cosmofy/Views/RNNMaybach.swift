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
                ScrollView {
                    VStack {
//                        HStack {
//                            Text("Nature")
//                                .font(Font.custom("SF Pro Rounded Bold", size: 34))
//                            Text("Scope")
//                                .font(Font.custom("SF Pro Rounded Bold", size: 34))
//                                .foregroundStyle(.secondary)
//                            Spacer()
//                        }
//                        .padding([.top, .horizontal])
                        
                        HStack {
                            Text("Overview")
                                .font(Font.custom("SF Pro Rounded Medium", size: 20))
                            
                            Spacer()
                        }
                        .padding([.horizontal])
                        
                        
                        ZStack {
                            Color.mint
                            
                            VStack(alignment: .leading) {
                                Text("Nature Scope offers real-time access to natural events and disasters happening around the world. This data is provided by NASA.")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.vertical)
                                    .padding(.horizontal, 8)
                                    .multilineTextAlignment(.leading)
                                
                                Text("The events being shown are only for the year 2024.")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.bottom)
                                    .padding(.horizontal, 8)
                                    .multilineTextAlignment(.leading)
                            }
                            
                        }
                        
                        
                        
                        ProgressView("Loading Events...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        

                        
                        VStack {
                            HStack {
                                Text("List of all the available event categories supported:")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            
                            ForEach(categories) { category in
                                categoryView(category: category)
                                    .padding(.horizontal)
                                    .padding(.vertical, 2)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .navigationTitle("Nature Scope")
                .onAppear {
                    UINavigationBar.appearance().largeTitleTextAttributes = [
                        .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                    ]
                }

                
            } else if errorMessage != nil {
                Text(errorMessage ?? "Unknown error")
                    .padding()
                    .foregroundColor(.red)
            } else {
                
                ScrollView {
                    VStack {
//                        HStack {
//                            Text("Nature")
//                                .font(Font.custom("SF Pro Rounded Bold", size: 34))
//                            Text("Scope")
//                                .font(Font.custom("SF Pro Rounded Bold", size: 34))
//                                .foregroundStyle(.secondary)
//                            Spacer()
//                        }
//                        .padding([.top, .horizontal])
                        
                        HStack {
                            Text("Overview")
                                .font(Font.custom("SF Pro Rounded Medium", size: 20))
                            
                            Spacer()
                        }
                        .padding([.horizontal])
                        
                        
                        ZStack {
                            Color.mint
                            
                            VStack(alignment: .leading) {
                                Text("Nature Scope offers real-time access to natural events and disasters happening around the world. This data is provided by NASA.")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.vertical)
                                    .padding(.horizontal, 8)
                                    .multilineTextAlignment(.leading)
                                
                                Text("The events being shown are only for the year 2024.")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.bottom)
                                    .padding(.horizontal, 8)
                                    .multilineTextAlignment(.leading)
                            }
                            
                        }
                        
                        NavigationLink(destination: ZStack {
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
                            .sheet(isPresented: $showDetails) {
                                ScrollView(.vertical, content: {
                                    VStack(alignment: .leading, spacing: 15, content: {
                                        MapDetails(event: selectedResult, visible: $showDetails, weatherViewModel: weatherViewModel) // Pass here
                                            .presentationDetents([.height(212)])
                                            .presentationBackgroundInteraction(.enabled(upThrough: .height(212)))
                                            .presentationCornerRadius(24)
                                    })
                                    .padding()
                                })
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .presentationDetents([.height(212), .medium, .large])
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
                        .toolbar(.hidden)
                        ) {
                            HStack() {
                                Text("View Events")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .foregroundStyle(.green)
                                    .padding(.vertical)
                                    .padding(.horizontal, 16)

                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.green)
                                    .padding(.horizontal, 24)

                                
                            }
                            .padding(.top, 8)

                        }
                        

                        
                        VStack {
                            HStack {
                                Text("List of all the available event categories supported:")
                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            
                            
                            ForEach(categories) { category in
                                categoryView(category: category)
                                    .padding(.horizontal)
                                    .padding(.vertical, 2)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .navigationTitle("Nature Scope")
                .onAppear {
                    UINavigationBar.appearance().largeTitleTextAttributes = [
                        .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont.systemFont(ofSize: 34, weight: .semibold),
                    ]
                }
    

            }
        }
        .onChange(of: selectedResult) { oldValue, newValue in
            showDetails = newValue != nil
        }
        .toolbar(.hidden)
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

@ViewBuilder
func categoryView(category: Category) -> some View {
    VStack(alignment: .leading, spacing: 2) {
        HStack {
            Image(systemName: "smallcircle.filled.circle.fill")
                .font(.caption2)
            Text(category.title)
                .font(Font.custom("SF Pro Rounded Medium", size: 16))
            Spacer()
        }
//        Text(category.description)
//            .foregroundStyle(.secondary)
//            .font(Font.custom("SF Pro Rounded Regular", size: 14))
//            .multilineTextAlignment(.leading)
    }
}


struct EONETInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("NASA's EONET API")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Overview")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("The Earth Observatory Natural Event Tracker (EONET) API provides access to a curated source of natural event information. This API allows users to obtain real-time data about natural events around the world.")
                .padding(.bottom, 10)
            
            Text("Key Features")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.blue)
                    Text("Real-time data on natural events such as wildfires, volcanic eruptions, and hurricanes.")
                }
                
                HStack(alignment: .top) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.blue)
                    Text("Categorized data to filter events by type, date, and location.")
                }
                
                HStack(alignment: .top) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.blue)
                    Text("Geospatial information to visualize event locations on maps.")
                }
                
                HStack(alignment: .top) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.blue)
                    Text("Access to metadata and links to satellite imagery for detailed analysis.")
                }
                
                HStack(alignment: .top) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundColor(.blue)
                    Text("Historical data archive for tracking the progression and impact of past events.")
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.9))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
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
