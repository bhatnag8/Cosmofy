//
//  RNNMaybach.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 5/7/24.
//

import SwiftUI
import MapKit

struct RNNMaybach: View {
    @State private var events = [Event]()
    @State private var errorMessage: String?
    @State private var coors = [CLLocationCoordinate2D]()
    
    @State private var selectedResult: Event?
    @State private var showDetails: Bool = false
        
    var body: some View {
        NavigationView {
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
            .mapStyle(.standard(elevation: .realistic))
            .onAppear {
                NetworkManager().fetchEvents { result in
                    switch result {
                    case .success(let events):
                        self.events = events
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
            .alert(isPresented: .constant(errorMessage != nil), content: {
                Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            })
            .sheet(isPresented: $showDetails) {
                Haptics.shared.impact(for: .medium)
            } content: {
                MapDetails(event: selectedResult)
                    .presentationDetents([.height(300)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                    .presentationCornerRadius(24)
            }
        }
        .onChange(of: selectedResult) { oldValue, newValue in
            showDetails = newValue != nil
        }
    }
    
    @ViewBuilder
    func MapDetails(event: Event?) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text("Map Details")
            }
            .padding(.horizontal)
        }
    }
    
    
    // Function to determine the marker image based on the event title
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
    
    // Function to determine the marker tint color based on the event title
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
                return .darkOrange
        default:
                return .yellow
        }
    }
}

#Preview {
    RNNMaybach()
}
