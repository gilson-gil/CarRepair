//
//  PlaceDetailsRequest.swift
//  CarRepair
//
//  Created by Gilson Gil on 27/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct PlaceDetailsRequest: Encodable {
    let placeId: String
    let key: String = Constants.googlePlacesAPIKey.rawValue

    enum CodingKeys: String, CodingKey {
        case placeId = "placeid"
        case key
    }
}
