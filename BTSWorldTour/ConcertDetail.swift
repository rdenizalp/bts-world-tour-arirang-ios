//
//  ConcertDetail.swift
//  BTSWorldTour
//
//  Created by Deniz Alp on 25.01.2026.
//

import SwiftUI
import MapKit

struct ConcertDetail: View {
    let concerts: BtsConcert
   
    
    @State private var expandedIDs: Set<UUID> = []
    @State var position: MapCameraPosition
    
    @Namespace var namespace
    
    var body: some View {
            ScrollView {
                    
                ZStack {
                    Image(.ariranglogo)
                        .resizable()
                        .scaledToFit()
                        
                }
                Link(destination: URL(string: concerts.ticketUrl)!) {
                    VStack(alignment: .leading){
                        VStack(alignment: .leading, spacing: 8) {
                            // Arirang image
                            
                            
                            
                            
                            Text(concerts.city)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            
                            Text(concerts.country)
                                .font(.subheadline)
                                .foregroundStyle(.black)
                            
                            Label(concerts.venue, systemImage: "mappin.and.ellipse")
                                .font(.subheadline)
                            
                                .foregroundStyle(.black)
                            
                            Label(concerts.date.formattedDate(), systemImage: "calendar")
                                .font(.caption)
                                .foregroundStyle(.black)
                            
                            
                            
                            
                            Divider()
                                .overlay(
                                    Rectangle()
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                                        .foregroundStyle(.primary.opacity(0.5))
                                )
                            
                            Text(concerts.info)
                                .font(.caption)
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                        }
                        .padding(16)
                        .background(.red)
                        .overlay(
                            Image(systemName: "ticket.fill")
                                .font(.caption)
                                .foregroundStyle(.black)
                                .padding(10),
                            alignment: .topTrailing
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                        .padding(.horizontal)
                        
                        
                        //Concert Date
                        if let date = concerts.date.toDateYYYYMMDD() {
                            CountdownView(targetDate: date)
                                .padding(.horizontal)
                        }
                        
                        // Current Location
                        NavigationLink {
                            ConcertMap(position: .camera(MapCamera(
                                centerCoordinate: concerts.location,
                                distance: 1000,
                                heading: 250,
                                pitch: 80))
                            )
                            .navigationTransition(.zoom(sourceID: 1, in: namespace))
                            
                        } label: {
                            Map(position: $position) {
                                Annotation(concerts.venue, coordinate: concerts.location) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .symbolEffect(.pulse)
                                }
                            }
                            .frame(height: 125)
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                            .overlay(alignment: .trailing) {
                                Image(systemName: "greaterthan")
                                    .imageScale(.large)
                                    .font(.title3)
                                
                                
                            }
                            .padding(.horizontal)
                        }
                        .matchedTransitionSource(id: 1, in: namespace)
                        
                        
                        
                        //FAQSectionView
                        FAQSectionView(items: FAQData.items, expandedIDs: $expandedIDs)
                        
                            .padding()
                    }
                }
              
            }
            .toolbarBackground(.automatic)
        }
        
        
    }
  


#Preview {
    let concert = Concert().btsConcert[0]
    
    NavigationStack {
        ConcertDetail(concerts: concert, position: .camera(
            MapCamera(
                centerCoordinate: concert.location, distance: 500
            )))
    }
}
