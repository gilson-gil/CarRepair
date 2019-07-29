//
//  ListViewModel.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation
import CoreLocation

final class ListViewModel {
    private let repository: CarRepairRepository
    private let imageRepository: ImageRepository
    var state: LoadingState = .stopped
    var location: Location?
    var placeResponse: PlaceResponse? {
        didSet {
            cellConfigurators = placeResponse?.results.compactMap {
                ListViewModel.createCellConfigurator(location: location,
                                                     place: $0,
                                                     distanceFormatter: distanceFormatter,
                                                     imageRepository: imageRepository)
            } ?? []
        }
    }
    var cellConfigurators: [CellConfiguratorType] = []
    let distanceFormatter: DistanceFormatter = .init()

    init(repository: CarRepairRepository, imageRepository: ImageRepository) {
        self.repository = repository
        self.imageRepository = imageRepository
    }

    func fetchFirstPage(location: Location?, forceRefresh: Bool = false, completion: @escaping (Bool) -> Void) {
        self.location = location
        guard forceRefresh || state == .stopped else { return completion(false) }
        state = .loading
        repository.getList(from: location) { result in
            do {
                let placeResponse = try result.get()
                self.state = .success
                self.placeResponse = placeResponse
            } catch {
                self.state = .stopped
            }
            completion(true)
        }
    }

    func fetchNextPage(completion: @escaping () -> Void) {
        guard state != .loading else { return }
        guard let pageToken = placeResponse?.nextPageToken else { return }
        state = .loading
        repository.getList(with: pageToken) { result in
            do {
                let placeResponse = try result.get()
                self.state = .success
                let previousPlaces = (self.placeResponse?.results ?? [])
                let places = previousPlaces + placeResponse.results
                self.placeResponse = placeResponse
                self.placeResponse?.results = places
                completion()
            } catch {
                self.state = .failure(error)
                completion()
            }
        }
    }

    func getNumberOfRows() -> Int {
        return cellConfigurators.count
    }

    func getConfigurator(at indexPath: IndexPath) -> CellConfiguratorType {
        return cellConfigurators[indexPath.row]
    }

    func getPlace(at indexPath: IndexPath) -> Place? {
        return placeResponse?.results[indexPath.row]
    }

    static func createCellConfigurator(location: Location?,
                                       place: Place,
                                       distanceFormatter: DistanceFormatter,
                                       imageRepository: ImageRepository) -> CellConfiguratorType {
        let distance: Double?
        if let location = location {
            distance = CLLocation(latitude: location.latitude, longitude: location.longitude)
                .distance(from: .init(latitude: place.location.latitude, longitude: place.location.longitude))
        } else {
            distance = nil
        }
        let distanceString = distanceFormatter.format(value: distance)
        return CellConfigurator<ListItemCell>(viewModel: ListItemCellViewModel(place: place,
                                                                               placeDistance: distanceString,
                                                                               imageRepository: imageRepository,
                                                                               isDetail: false))
    }
}
