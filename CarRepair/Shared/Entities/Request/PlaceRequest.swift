//
//  PlaceRequest.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct PlaceRequest: Encodable {
    let location: Location
    let rankby: String = "distance"
    let types: String
    let key: String = Constants.googlePlacesAPIKey.rawValue

    enum CodingKeys: String, CodingKey {
        case location
        case rankby
        case types
        case key
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("\(location.latitude),\(location.longitude)", forKey: .location)
        try container.encode(rankby, forKey: .rankby)
        try container.encode(types, forKey: .types)
        try container.encode(key, forKey: .key)
    }
}
