//
//  Review.swift
//  CarRepair
//
//  Created by Gilson Gil on 27/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct Review: Decodable {
    let author: String
    let profileUrl: String
    let timePast: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case author = "authorName"
        case profileUrl = "profilePhotoUrl"
        case timePast = "relativeTimeDescription"
        case text
    }
}
