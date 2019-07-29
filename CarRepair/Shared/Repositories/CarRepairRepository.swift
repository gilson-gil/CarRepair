//
//  CarRepairRepository.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum CarRepairRepositoryError: LocalizedError {
    case locationRequired
    case endReached

    var localizedDescription: String {
        return ""
    }
}

protocol CarRepairRepository {
    func getList(from location: Location?,
                 completion: @escaping (Result<PlaceResponse, CarRepairRepositoryError>) -> Void)
    func getList(with token: String,
                 completion: @escaping (Result<PlaceResponse, CarRepairRepositoryError>) -> Void)
    func getDetails(for placeId: String,
                    completion: @escaping (Result<Place, HTTPError>) -> Void)
}
