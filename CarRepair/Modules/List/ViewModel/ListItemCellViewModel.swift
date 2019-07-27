//
//  ListItemCellViewModel.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct ListItemCellViewModel {
    let iconURL: String
    let name: String
    let isOpen: Bool
    let distance: String
    let address: String
    let imageRepository: ImageRepository

    init(place: Place, placeDistance: String, imageRepository: ImageRepository) {
        iconURL = place.icon.valid
        name = place.name.capitalized
        isOpen = place.isOpen ?? false
        distance = placeDistance
        address = place.address.capitalized
        self.imageRepository = imageRepository
    }
}
