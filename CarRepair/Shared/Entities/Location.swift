//
//  Location.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Codable {
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }

    init?(location: CLLocation?) {
        guard let location = location else { return nil }
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}
