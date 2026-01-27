//
//  ContentView.swift
//  BTSWorldTour
//
//  Created by Deniz Alp on 22.01.2026.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let concerts = Concert()
    
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = Region.all
    
    var filteredConcert: [BtsConcert] {
        concerts.filter(by: currentSelection)
        concerts.sort(by: alphabetical)
        
        
        
        return concerts.search(for: searchText)
        }
    
    
    var body: some View {
        NavigationStack {
                Image(.btsworldtour)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius:7)
                
                List(filteredConcert) { concert in
                    NavigationLink {
                        ConcertDetail(concerts: concert, position: .camera(
                            MapCamera(
                                centerCoordinate: concert.location, distance: 500
                            )))
                        
                    }label: {
                        HStack {
                            //Arirang image
                            Image(.arirang2)
                                .resizable()
                                .scaledToFit()
                                .frame(width:100, height: 100)
                            
                            
                            
                            VStack(alignment: .leading, spacing: 5) {
                                // City
                                
                                Text(concert.city)
                                    .font(.title)
                                    .fontWeight(.black)
                                //Country
                                
                                Text(concert.country)
                                    .fontWeight(.bold)
                                    .font(.title2)
                                
                                
                                //Venue
                                Text(concert.venue)
                                    .font(.title3)
                                
                                //Date
                                Label(concert.date.formattedDate(), systemImage: "ticket.fill")
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                                
                                
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
                .autocorrectionDisabled()
                .animation(.default, value:searchText)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                alphabetical.toggle()
                            }
                        }label: {
                            
                            Image(systemName: alphabetical ? "textformat" : "calendar")
                                .symbolEffect(.bounce, value: alphabetical)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Filter", selection: $currentSelection.animation()) {
                                ForEach(Region.allCases) { region in
                                    Label(region.rawValue.capitalized, systemImage: region.icon)
                                    
                                }
                            }
                            
                        } label: {
                            Image(systemName: "globe")
                        }
                    }
                }
            }

    }
}



#Preview {
    ContentView()
}
