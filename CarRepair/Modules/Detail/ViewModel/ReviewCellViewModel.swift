//
//  ReviewCellViewModel.swift
//  CarRepair
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct ReviewCellViewModel {
    let review: Review
    let imageRepository: ImageRepository

    var authorImageUrl: String {
        return review.profileUrl
    }

    var authorName: String {
        return review.author
    }

    var text: String {
        return review.text
    }

    var timePast: String {
        return review.timePast
    }
}
