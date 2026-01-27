//
//  ConcertMap.swift
//  BTSWorldTour
//
//  Created by Deniz Alp on 27.01.2026.
//

import SwiftUI
import MapKit

struct ConcertMap: View {
    let concerts = Concert()
    
    @State var position: MapCameraPosition
    @State var satellite = false
    
    var body: some View {
        Map(position: $position){
            ForEach(concerts.btsConcert) { concert in
                Annotation(concert.venue, coordinate: concert.location) {
                    Image(.tour)
                        .resizable()
                        .scaledToFit()
                        .frame(height:50)
                        .shadow(color: .white, radius: 3)
                }
            }
        }
        .mapStyle(satellite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satellite.toggle()
            } label: {
                Image(systemName: satellite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 99))
                    .shadow(radius: 3)
                    .padding()
            }
            
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    ConcertMap(position: .camera(MapCamera(
        centerCoordinate: Concert().btsConcert[0].location,
        distance: 1000,
        heading: 250,
        pitch: 80)))
}
