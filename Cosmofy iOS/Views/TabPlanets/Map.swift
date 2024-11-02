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
                        VTabView(indexPosition: .trailing) {
                            // View 1
                            VStack {
                                VStack(spacing: 4) {
                                    VStack(spacing: 2) {
                                        HStack {
                                            Text("event Title")
                                                .font(.caption)
                                                .textCase(.uppercase)
                                                .foregroundStyle(.secondary)
                                            Spacer()
                                        }
                                        Divider()
                                    }
                                    .padding(.trailing, 50)
                                    
                                    HStack {
                                        Text(event?.title ?? "")
                                            .multilineTextAlignment(.leading)
                                            .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                        
                                        Spacer()
                                    }
                                    .padding(.trailing, 50)
                                }

                                
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
                                                    Text("Category")
                                                        .font(.caption)
                                                        .foregroundStyle(.secondary)
                                                    Spacer()
                                                }
                                            }
                                            Spacer()
                                        }
                                        
                                        Spacer()
                                        
                                        HStack {

                                            
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
                                            
                                            Spacer()
                                            
                                            Text("Weather")
                                                .fontWeight(.medium)
                                            
                                            
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
                                                Text("Date")
                                                    .font(.caption)
                                                    .textCase(.uppercase)
                                                    .foregroundStyle(.secondary)
                                                Spacer()
                                            }
                                            Divider()
                                        }
                                        .padding(.trailing, 50)

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
                                                Text("Dates")
                                                    .font(.caption)
                                                    .textCase(.uppercase)
                                                    .foregroundStyle(.secondary)
                                                Spacer()
                                            }
                                            Divider()
                                        }
                                        .padding(.trailing, 50)

                                        HStack {
                                            Text("\(formattedDate(from: event?.geometry.first?.date ?? "")) to")
                                                .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                            Spacer()
                                        }
                                        HStack {
                                            Text(formattedDate(from: event?.geometry.last?.date ?? ""))
                                                .font(Font.custom("SF Pro Rounded Medium", size: 18))
                                            Spacer()
                                        }
                                    }
                                    .padding(.top, 6)
                                    

                                }
                                
                                
                                if let sources = event?.sources {
                                    VStack(spacing: 2) {
                                        HStack {
                                            Text("sources")
                                                .font(.caption)
                                                .textCase(.uppercase)
                                                .foregroundStyle(.secondary)
                                            Spacer()
                                        }
                                        Divider()
                                    }
                                    .padding(.trailing, 50)
                                    .padding(.top)
                                    
                                    ForEach(sources) { source in
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
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .padding()
                        .frame(height: 200)
                        .frame(maxWidth: 500)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
                
                
            }
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont(descriptor: UIFont.systemFont(ofSize: 34, weight: .semibold).fontDescriptor.withDesign(.rounded)!, size: 34),
                ]
            }            
            .navigationTitle("‎‎‏‏‎Map")

            #if !os(tvOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
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
                            Text("Browse the Entire EARTH For Natural Events and disasters as They Occur")
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
                            
                            DisclosureGroup(category.title) // 1
                            { // 2
                                HStack {
                                    Text(category.id)
                                        .font(.title)
                                        .fontDesign(.serif)
                                        .frame(width: 45)
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
//                        .padding(.vertical, 8)
                        
                        
                    }
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "SF Pro Rounded Bold", size: 34) ?? UIFont(descriptor: UIFont.systemFont(ofSize: 34, weight: .semibold).fontDescriptor.withDesign(.rounded)!, size: 34),
                ]
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

