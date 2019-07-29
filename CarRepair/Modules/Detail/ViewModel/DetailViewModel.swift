//
//  DetailViewModel.swift
//  CarRepair
//
//  Created by Gilson Gil on 25/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import CoreLocation
import UIKit

final class DetailViewModel {
    var place: Place
    private let repository: CarRepairRepository
    private let photoRepository: PhotoRepository
    private let imageRepository: ImageRepository
    var directionsManager: DirectionsManager = .init()
    let configurators: [[CellConfiguratorType]]

    init(place: Place,
         location: Location?,
         repository: CarRepairRepository,
         photoRepository: PhotoRepository,
         imageRepository: ImageRepository) {
        self.place = place
        self.repository = repository
        self.photoRepository = photoRepository
        self.imageRepository = imageRepository
        let distance: Double?
        if let location = location {
            distance = CLLocation(latitude: location.latitude, longitude: location.longitude)
                .distance(from: .init(latitude: place.location.latitude, longitude: place.location.longitude))
        } else {
            distance = nil
        }
        let distanceString = DistanceFormatter().format(value: distance)
        configurators = [
            [
                CellConfigurator<PhotosCell>(viewModel: .init(place: place, photoRepository: photoRepository))
            ],
            [
                CellConfigurator<ListItemCell>(viewModel: .init(place: place,
                                                                placeDistance: distanceString,
                                                                imageRepository: imageRepository,
                                                                isDetail: true))
            ],
            [
                CellConfigurator<MapCell>(viewModel: .init(place: place))
            ]
        ]
    }

    var placeName: String {
        return place.name.capitalized
    }

    var numberOfSections: Int {
        return configurators.count
    }

    func numberOfRows(at section: Int) -> Int {
        return configurators[section].count
    }

    func configurator(at indexPath: IndexPath) -> CellConfiguratorType {
        return configurators[indexPath.section][indexPath.row]
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

    func fetchDetails(completion: @escaping () -> Void) {
        repository.getDetails(for: place.placeId) { result in
            guard case let .success(place) = result else { return }
            self.place = place
            completion()
        }
    }
}
