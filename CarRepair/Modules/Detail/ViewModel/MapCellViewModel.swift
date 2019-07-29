//
//  MapCellViewModel.swift
//  CarRepair
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct MapCellViewModel {
    let place: Place

    var placeLocation: Location {
        return place.location
    }
}
