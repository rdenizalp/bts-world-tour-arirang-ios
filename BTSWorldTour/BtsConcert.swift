//
//  Concert.swift
//  BTSWorldTour
//
//  Created by Deniz Alp on 24.01.2026.
//

import SwiftUI
import Foundation
import MapKit

struct BtsConcert: Decodable, Identifiable {
    let id: Int
    let city: String
    let country: String
    let venue: String
    let latitude: Double
    let longitude: Double
    let date: String
    let ticketUrl: String
    let info: String
    let region: Region?
    
    
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude,longitude:  longitude)
    }
    
}

enum Region: String, Decodable, CaseIterable, Identifiable {
    case all
    case europe
    case us
    case asia
    
    var id: Region {
        self
    }
    
    var title: String {
        switch self {
        case .all: "All"
        case .europe: "Europe"
        case .us: "US"
        case .asia: "Asia"
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "globe"
        case .europe:
            "globe.europe.africa"
        case .us:
            "globe.americas"
        case .asia:
            "globe.asia.australia"
        }
    }
}


