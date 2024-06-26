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
//                .onTapGesture {
//                    
//                }

                .onChange(of: event, { old, new in
                    if new != nil {
                        withAnimation {
                            selected = true
                        }
                    } else {
                        withAnimation {
                            selected = false
                        }
                    }
                })
                .mapControls {
                    MapCompass()
                    MapScaleView()
                    MapPitchToggle()
                }
                .mapStyle(.standard(elevation: .realistic))
                .alert(isPresented: .constant(fetchedErrorMessage != nil), content: {
                    Alert(title: Text("Error"), message: Text(fetchedErrorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
                })
                
                if selected {
                    VStack {
                        Spacer()
                        ZStack {
                            VTabView(indexPosition: .trailing) {
                                // View 1
                                VStack {
                                    VStack(spacing: 2) {
                                        HStack {
                                            Text("Event name")
                                                .font(.caption)
                                                .textCase(.uppercase)
                                                .foregroundStyle(.secondary)
                                            Spacer()
                                        }
                                        Divider()
                                    }
                                    .padding(.trailing, 78)
                                    
                                    HStack {
                                        Text(event?.title ?? "")
                                            .multilineTextAlignment(.leading)
                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                        
                                        Spacer()
                                    }
                                    .padding(.trailing, 78)
                                    
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
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 16))
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
                                                    .font(.callout)
                                                
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
                                    if event?.geometry.first?.date == event?.geometry.last?.date {
                                        VStack(spacing: 4) {
                                            VStack(spacing: 2) {
                                                HStack {
                                                    Text("Recorded on")
                                                        .font(.caption)
                                                        .textCase(.uppercase)
                                                        .foregroundStyle(.secondary)
                                                    Spacer()
                                                }
                                                Divider()
                                            }
                                            .padding(.trailing, 78)

                                            HStack {
                                                Text(formattedDate(from: event?.geometry.first?.date ?? ""))
                                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                Spacer()
                                            }
                                        }
                                        .padding(.top, 6)
                                    } else {
                                        VStack(spacing: 4) {
                                            VStack(spacing: 2) {
                                                HStack {
                                                    Text("First Record")
                                                        .font(.caption)
                                                        .textCase(.uppercase)
                                                        .foregroundStyle(.secondary)
                                                    Spacer()
                                                }
                                                Divider()
                                            }
                                            .padding(.trailing, 78)

                                            HStack {
                                                Text(formattedDate(from: event?.geometry.first?.date ?? ""))
                                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                Spacer()
                                            }
                                        }
                                        .padding(.top, 6)
                                        
                                        
                                        VStack(spacing: 4) {
                                            VStack(spacing: 2) {
                                                HStack {
                                                    Text("Latest Record")
                                                        .font(.caption)
                                                        .textCase(.uppercase)
                                                        .foregroundStyle(.secondary)
                                                    Spacer()
                                                }
                                                Divider()
                                            }
                                            .padding(.trailing, 78)

                                            HStack {
                                                Text(formattedDate(from: event?.geometry.last?.date ?? ""))
                                                    .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                Spacer()
                                            }
                                        }
                                        .padding(.top, 6)
                                    }
                                    
                                    
                                    if let sources = event?.sources {
                                        ForEach(sources) { source in
                                            VStack(spacing: 4) {
                                                VStack(spacing: 2) {
                                                    HStack {
                                                        Text("source")
                                                            .font(.caption)
                                                            .textCase(.uppercase)
                                                            .foregroundStyle(.secondary)
                                                        Spacer()
                                                    }
                                                    Divider()
                                                }
                                                .padding(.trailing, 78)

                                                HStack {
                                                    if source.id == "GDACS" {
                                                        Text("Global Disaster Alert and Coordination System")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "AVO" {
                                                        Text("Alaska Volcano Observatory")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "ABFIRE" {
                                                        Text("Alberta Wildfire")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "AU_BOM" {
                                                        Text("Australia Bureau of Meteorology")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "BYU_ICE" {
                                                        Text("Brigham Young University Antarctic Iceberg Tracking Database")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "BCWILDFIRE" {
                                                        Text("British Columbia Wildfire Service")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "CALFIRE" {
                                                        Text("California Department of Forestry and Fire Protection")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "CEMS" {
                                                        Text("Copernicus Emergency Management Service")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "EO" {
                                                        Text("Earth Observatory")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "Earthdata" {
                                                        Text("Earthdata")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "FEMA" {
                                                        Text("Federal Emergency Management Agency (FEMA)")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "FloodList" {
                                                        Text("FloodList")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "GLIDE" {
                                                        Text("GLobal IDEntifier Number (GLIDE)")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "InciWeb" {
                                                        Text("InciWeb")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "IRWIN" {
                                                        Text("Integrated Reporting of Wildfire Information (IRWIN) Observer")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "IDC" {
                                                        Text("International Charter on Space and Major Disasters")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "JTWC" {
                                                        Text("Joint Typhoon Warning Center")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "MRR" {
                                                        Text("LANCE Rapid Response")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "MBFIRE" {
                                                        Text("Manitoba Wildfire Program")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "NASA_ESRS" {
                                                        Text("NASA Earth Science and Remote Sensing Unit")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "NASA_DISP" {
                                                        Text("NASA Earth Science Disasters Program")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "NASA_HURR" {
                                                        Text("NASA Hurricane And Typhoon Updates")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "NOAA_NHC" {
                                                        Text("National Hurricane Center")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "NOAA_CPC" {
                                                        Text("NOAA Center for Weather and Climate Prediction")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "PDC" {
                                                        Text("Pacific Disaster Center")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "ReliefWeb" {
                                                        Text("ReliefWeb")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "SIVolcano" {
                                                        Text("Smithsonian Institution Global Volcanism Program")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "NATICE" {
                                                        Text("U.S. National Ice Center")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "UNISYS" {
                                                        Text("Unisys Weather")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "USGS_EHP" {
                                                        Text("USGS Earthquake Hazards Program")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "USGS_CMT" {
                                                        Text("USGS Emergency Operations Collection Management Tool")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "HDDS" {
                                                        Text("USGS Hazards Data Distribution System")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    } else if source.id == "DFES_WA" {
                                                        Text("Western Australia Department of Fire and Emergency Services")
                                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                                    }
                                                    Spacer()
                                                }
                                            }
                                            .padding(.top, 6)
                                        }
                                    }
                                }
                            }
                            .tabViewStyle(PageTabViewStyle())
                            .padding()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            
                            HStack {
                                Spacer()
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(.top, -72)
                                    .padding(.trailing, 28)
                                    .foregroundStyle(.white)
                                    .onTapGesture {
                                        withAnimation {
                                            selected = false
                                        }
                                    }
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
                
                
            }
            .navigationTitle("‎‎‏‏‎Map")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct RNNMaybach: View {
    @Binding var complete: Bool
    @Binding var failed: Bool
    
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
                        Text("Displaying all events since \(getFormattedDate14DaysAgo())")
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.secondary)
                            .fontDesign(.serif)
                            .italic()
                        Spacer()
                    }
                    .padding(.top, 2)
                    .padding(.bottom, 8)
                    
                    if complete {
                        
                        NavigationLink(destination: MapWithEvents()) {
                            
                            HStack {
                                Text("Enter Nature Scope")
                                    .frame(maxWidth: .infinity)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                            }
                            .frame(height: 30)
                            .padding()
                            .background(Color.green.cornerRadius(8))
                            
                        }
                    } else if failed {
                        HStack {
                            Text("Failed to Launch")
                                .frame(maxWidth: .infinity)
                                .fontWeight(.medium)
                                .foregroundColor(Color.white)
                        }
                        .frame(height: 30)
                        .padding()
                        .background(Color.red.cornerRadius(8))
                    } else {
                        ProgressView("Loading...")
                            .frame(height: 30)
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
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
        }
        
    }
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

func getFormattedDate14DaysAgo() -> String {
    // Get the current date
    let currentDate = Date()
    
    // Subtract 14 days from the current date
    guard let date14DaysAgo = Calendar.current.date(byAdding: .day, value: -15, to: currentDate) else {
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

func getSourceTitle(by id: String) -> String? {
    return sources.first { $0.id == id }?.title
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

struct Source: Identifiable {
    let id: String
    let title: String
    let source: String
}

let sources: [Source] = [
    Source(id: "AVO", title: "Alaska Volcano Observatory", source: "https://www.avo.alaska.edu/"),
    Source(id: "ABFIRE", title: "Alberta Wildfire", source: "https://wildfire.alberta.ca/"),
    Source(id: "AU_BOM", title: "Australia Bureau of Meteorology", source: "http://www.bom.gov.au/"),
    Source(id: "BYU_ICE", title: "Brigham Young University Antarctic Iceberg Tracking Database", source: "http://www.scp.byu.edu/data/iceberg/database1.html"),
    Source(id: "BCWILDFIRE", title: "British Columbia Wildfire Service", source: "http://bcwildfire.ca/"),
    Source(id: "CALFIRE", title: "California Department of Forestry and Fire Protection", source: "http://www.calfire.ca.gov/"),
    Source(id: "CEMS", title: "Copernicus Emergency Management Service", source: "http://emergency.copernicus.eu/"),
    Source(id: "EO", title: "Earth Observatory", source: "https://earthobservatory.nasa.gov/"),
    Source(id: "Earthdata", title: "Earthdata", source: "https://earthdata.nasa.gov"),
    Source(id: "FEMA", title: "Federal Emergency Management Agency (FEMA)", source: "https://www.fema.gov/"),
    Source(id: "FloodList", title: "FloodList", source: "http://floodlist.com/"),
    Source(id: "GDACS", title: "Global Disaster Alert and Coordination System", source: "http://www.gdacs.org/"),
    Source(id: "GLIDE", title: "GLobal IDEntifier Number (GLIDE)", source: "http://www.glidenumber.net/"),
    Source(id: "InciWeb", title: "InciWeb", source: "https://inciweb.nwcg.gov/"),
    Source(id: "IRWIN", title: "Integrated Reporting of Wildfire Information (IRWIN) Observer", source: "https://irwin.doi.gov/observer/"),
    Source(id: "IDC", title: "International Charter on Space and Major Disasters", source: "https://www.disasterscharter.org/"),
    Source(id: "JTWC", title: "Joint Typhoon Warning Center", source: "http://www.metoc.navy.mil/jtwc/jtwc.html"),
    Source(id: "MRR", title: "LANCE Rapid Response", source: "https://lance.modaps.eosdis.nasa.gov/cgi-bin/imagery/gallery.cgi"),
    Source(id: "MBFIRE", title: "Manitoba Wildfire Program", source: "http://www.gov.mb.ca/sd/fire/Fire-Maps/"),
    Source(id: "NASA_ESRS", title: "NASA Earth Science and Remote Sensing Unit", source: "https://eol.jsc.nasa.gov/ESRS/"),
    Source(id: "NASA_DISP", title: "NASA Earth Science Disasters Program", source: "https://disasters.nasa.gov/"),
    Source(id: "NASA_HURR", title: "NASA Hurricane And Typhoon Updates", source: "https://blogs.nasa.gov/hurricanes/"),
    Source(id: "NOAA_NHC", title: "National Hurricane Center", source: "https://www.nhc.noaa.gov/"),
    Source(id: "NOAA_CPC", title: "NOAA Center for Weather and Climate Prediction", source: "http://www.cpc.ncep.noaa.gov/"),
    Source(id: "PDC", title: "Pacific Disaster Center", source: "http://www.pdc.org/"),
    Source(id: "ReliefWeb", title: "ReliefWeb", source: "http://reliefweb.int/"),
    Source(id: "SIVolcano", title: "Smithsonian Institution Global Volcanism Program", source: "http://www.volcano.si.edu/"),
    Source(id: "NATICE", title: "U.S. National Ice Center", source: "http://www.natice.noaa.gov/Main_Products.htm"),
    Source(id: "UNISYS", title: "Unisys Weather", source: "http://weather.unisys.com/hurricane/"),
    Source(id: "USGS_EHP", title: "USGS Earthquake Hazards Program", source: "https://earthquake.usgs.gov/"),
    Source(id: "USGS_CMT", title: "USGS Emergency Operations Collection Management Tool", source: "https://cmt.usgs.gov/"),
    Source(id: "HDDS", title: "USGS Hazards Data Distribution System", source: "https://hddsexplorer.usgs.gov/"),
    Source(id: "DFES_WA", title: "Western Australia Department of Fire and Emergency Services", source: "https://www.dfes.wa.gov.au/")
]
