//
//  DirectionsManager.swift
//  CarRepair
//
//  Created by Gilson Gil on 26/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit
import MapKit

enum MapsApp: String, CaseIterable {
    case appleMaps = "applemaps"
    case maps = "comgooglemaps"
    case waze = "waze"

    var title: String {
        switch self {
        case .appleMaps:
            return "Apple Maps"
        case .maps:
            return "Google Maps"
        case .waze:
            return "Waze"
        }
    }

    func goTo(place: Place) {
        switch self {
        case .appleMaps:
            let placemark: MKPlacemark = .init(coordinate: place.coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = place.name
            mapItem.openInMaps(launchOptions: nil)
        case .maps:
            let query = "saddr=&daddr=\(place.coordinate.latitude),\(place.coordinate.longitude)&directionsmode=driving"
            guard let url = URL(string: "\(rawValue)://?\(query)") else { return }
            UIApplication.shared.open(url)
        case .waze:
            let query = "ll=\(place.coordinate.latitude),\(place.coordinate.longitude)&navigate=yes"
            guard let url = URL(string: "\(rawValue)://ul?\(query)") else { return }
            UIApplication.shared.open(url)
        }
    }
}

struct DirectionsManager {
    func availableApps() -> [MapsApp] {
        return [.appleMaps] + MapsApp.allCases.filter {
            guard let url = URL(string: "\($0)://") else { return false }
            return UIApplication.shared.canOpenURL(url)
        }
    }
}
