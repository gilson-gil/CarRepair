//
//  PlaceNextPageRequest.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct PlaceNextPageRequest: Encodable {
    let pagetoken: String
    let key: String = Constants.googlePlacesAPIKey.rawValue
}
