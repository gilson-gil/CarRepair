//
//  DetailViewModel.swift
//  CarRepair
//
//  Created by Gilson Gil on 25/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

struct DetailViewModel {
    let place: Place
    private let repository: PhotoRepository
    private let imageRepository: ImageRepository
    var photoConfigurators: [CellConfiguratorType]
    var directionsManager: DirectionsManager = .init()

    init(place: Place, repository: PhotoRepository, imageRepository: ImageRepository) {
        self.place = place
        self.repository = repository
        self.imageRepository = imageRepository
        photoConfigurators = place.photos.map {
            CellConfigurator<PhotoCell>(viewModel: PhotoCellViewModel(photo: $0, repository: repository))
        }
    }

    var placeName: String {
        return place.name.capitalized
    }

    var placePhotos: [Photo] {
        return place.photos
    }

    var placeAddress: String {
        return place.address.capitalized
    }

    var placeLocation: Location {
        return place.location
    }

    func getIconImage(completion: @escaping (UIImage?) -> Void) {
        guard let icon = place.icon else { return }
        imageRepository.getImage(url: icon) { result in
            completion(try? result.get())
        }
    }

    func availableApps() -> [MapsApp] {
        return directionsManager.availableApps()
    }
}
