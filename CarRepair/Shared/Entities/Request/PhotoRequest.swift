//
//  PhotoRequest.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct PhotoRequest: Encodable {
    let reference: String
    let key: String = Constants.googlePlacesAPIKey.rawValue

    enum CodingKeys: String, CodingKey {
        case reference = "photoreference"
        case key
    }
}
