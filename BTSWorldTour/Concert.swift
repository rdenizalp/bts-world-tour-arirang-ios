//
//  Untitled.swift
//  BTSWorldTour
//
//  Created by Deniz Alp on 24.01.2026.
//

import Foundation

class Concert {
    var allBtsConcert: [BtsConcert] = []
    
    var btsConcert: [BtsConcert] = []
    
    init() {
      decodeBtsConcertData()
    }
    
    func decodeBtsConcertData() {
        if let url = Bundle.main.url(forResource: "concert", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allBtsConcert = try decoder.decode([BtsConcert].self, from: data)
                btsConcert = allBtsConcert
                print("Decode OK: \(btsConcert.count) kayıt")
                
            } catch {
                print("Error decoding JSON data: \(error.localizedDescription)")
                print(error)
            }
        }
        
    }
    
    func search(for searchTerm: String) -> [BtsConcert] {
        if searchTerm.isEmpty {
            return btsConcert
        } else {
            return btsConcert.filter { concert in
                concert.city.localizedCaseInsensitiveContains(searchTerm) ||
                concert.country.localizedCaseInsensitiveContains(searchTerm) ||
                concert.venue.localizedCaseInsensitiveContains(searchTerm) ||
                concert.date.localizedCaseInsensitiveContains(searchTerm)
            }
        }
        
    }
    
    func sort(by alphabetical: Bool) {
        btsConcert.sort { concert1, concert2 in
            if alphabetical {
                concert1.city < concert2.city
            } else {
                concert1.id < concert2.id
            }
            
        }
    }
    func filter(by region: Region ) {
        if region == .all {
            btsConcert = allBtsConcert
            
        } else {
            btsConcert = allBtsConcert.filter { concert in
                concert.region == region
            }
        }
    }
}


