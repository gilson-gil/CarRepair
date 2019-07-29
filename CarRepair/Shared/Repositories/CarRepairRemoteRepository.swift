//
//  CarRepairRemoteRepository.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct CarRepairRemoteRepository: CarRepairRepository {
    let engine: NetworkEngine<CarRepairService> = .init()

    func getList(from location: Location?,
                 completion: @escaping (Result<PlaceResponse, CarRepairError>) -> Void) {
        guard let location = location else { return completion(.failure(.carRepairRepositoryError(.locationRequired))) }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        engine.request(
            target: CarRepairService.list(location),
            decoder: decoder) { (result: Result<PlaceResponse?, HTTPError>) in
                switch result {
                case .success(let response):
                    guard let nonEmpty = response else {
                        return completion(.failure(.carRepairRepositoryError(.endReached)))
                    }
                    completion(.success(nonEmpty))
                case .failure(let error):
                    completion(.failure(.httpError(error)))
                }
        }
    }

    func getList(with token: String,
                 completion: @escaping (Result<PlaceResponse, CarRepairError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        engine.request(
            target: CarRepairService.nextPage(token),
            decoder: decoder) { (result: Result<PlaceResponse?, HTTPError>) in
                guard case let .success(response) = result else {
                    return completion(.failure(.carRepairRepositoryError(.endReached)))
                }
                guard let nonEmpty = response else {
                    return completion(.failure(.carRepairRepositoryError(.endReached)))
                }
                completion(.success(nonEmpty))
        }
    }

    func getDetails(for placeId: String,
                    completion: @escaping (Result<Place, CarRepairError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        engine.request(
            target: CarRepairService.details(placeId),
            decoder: decoder) { (result: Result<PlaceDetailsResponse?, HTTPError>) in
                guard case let .success(response) = result, let place = response?.result else {
                    return completion(.failure(.httpError(.unknown)))
                }
                completion(.success(place))
        }
    }
}
