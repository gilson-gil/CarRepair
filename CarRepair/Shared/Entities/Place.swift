//
//  Place.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Place: Decodable {
    let location: Location
    let icon: String?
    let identifier: String
    let name: String
    let isOpen: Bool?
    let photos: [Photo]
    let placeId: String
    let rating: Float?
    let reference: String
    let ratingCount: Int
    let address: String

    enum CodingKeys: String, CodingKey {
        case location = "geometry"
        case icon
        case identifier = "id"
        case name
        case isOpen = "openingHours"
        case photos
        case placeId
        case rating
        case reference
        case ratingCount = "userRatingsTotal"
        case address = "vicinity"
    }

    enum GeometryCodingKeys: String, CodingKey {
        case location
    }

    enum OpeningHoursCodingKeys: String, CodingKey {
        case openNow
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let geometry = try container.nestedContainer(keyedBy: GeometryCodingKeys.self, forKey: .location)
        location = try geometry.decode(Location.self, forKey: .location)
        icon = try container.decode(String.self, forKey: .icon)
        identifier = try container.decode(String.self, forKey: .identifier)
        name = try container.decode(String.self, forKey: .name)
        let openingHours = try? container.nestedContainer(keyedBy: OpeningHoursCodingKeys.self, forKey: .isOpen)
        isOpen = try openingHours?.decodeIfPresent(Bool.self, forKey: .openNow)
        photos = try container.decodeIfPresent([Photo].self, forKey: .photos) ?? []
        placeId = try container.decode(String.self, forKey: .placeId)
        rating = try container.decodeIfPresent(Float.self, forKey: .rating)
        reference = try container.decode(String.self, forKey: .reference)
        ratingCount = try container.decodeIfPresent(Int.self, forKey: .ratingCount) ?? 0
        address = try container.decode(String.self, forKey: .address)
    }
}

extension Place: Equatable {
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.placeId == rhs.placeId
    }
}
