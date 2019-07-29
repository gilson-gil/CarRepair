//
//  PhotosCellViewModel.swift
//  CarRepair
//
//  Created by Gilson Gil on 28/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct PhotosCellViewModel {
    let place: Place
    let placePhotos: [Photo]
    let photoConfigurators: [CellConfiguratorType]

    init(place: Place, photoRepository: PhotoRepository) {
        self.place = place
        placePhotos = place.photos
        photoConfigurators = place.photos.map {
            CellConfigurator<PhotoCell>(viewModel: PhotoCellViewModel(photo: $0, repository: photoRepository))
        }
    }
}
