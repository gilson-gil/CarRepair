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
                 completion: @escaping (Result<PlaceResponse, CarRepairRepositoryError>) -> Void) {
        guard let location = location else { return completion(.failure(.locationRequired)) }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        engine.request(
            target: CarRepairService.list(location),
            decoder: decoder) { (result: Result<PlaceResponse?, HTTPError>) in
                guard case let .success(response) = result else { return }
                guard let nonEmpty = response else { return completion(.failure(.endReached)) }
                completion(.success(nonEmpty))
        }
    }

    func getList(with token: String,
                 completion: @escaping (Result<PlaceResponse, CarRepairRepositoryError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        engine.request(
            target: CarRepairService.nextPage(token),
            decoder: decoder) { (result: Result<PlaceResponse?, HTTPError>) in
                guard case let .success(response) = result else { return completion(.failure(.endReached)) }
                guard let nonEmpty = response else { return completion(.failure(.endReached)) }
                completion(.success(nonEmpty))
        }
    }
}
