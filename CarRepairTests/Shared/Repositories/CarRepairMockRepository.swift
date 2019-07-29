//
//  CarRepairMockRepository.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import Foundation

struct CarRepairMockRepository: CarRepairRepository {
    func getMockPlace() -> Place {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let file = Bundle(for: CarRepairServiceTests.self).url(forResource: "DetailsMock.json", withExtension: nil)!
        let data = try! Data(contentsOf: file)
        let json = try! decoder.decode(PlaceDetailsResponse.self, from: data)
        return json.result
    }

    func getList(from location: Location?,
                 completion: @escaping (Result<PlaceResponse, CarRepairError>) -> Void) {
        guard location != nil else { return completion(.failure(.carRepairRepositoryError(.locationRequired))) }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let file = Bundle(for: CarRepairServiceTests.self).url(forResource: "ListMock", withExtension: "json")!
        let data = try! Data(contentsOf: file)
        let json = try! decoder.decode(PlaceResponse.self, from: data)
        completion(.success(json))
    }

    func getList(with token: String,
                 completion: @escaping (Result<PlaceResponse, CarRepairError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let file = Bundle(for: CarRepairServiceTests.self).url(forResource: "ListNextPageMock.json", withExtension: nil)!
        let data = try! Data(contentsOf: file)
        let json = try! decoder.decode(PlaceResponse.self, from: data)
        completion(.success(json))
    }

    func getDetails(for placeId: String,
                    completion: @escaping (Result<Place, CarRepairError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let file = Bundle(for: CarRepairServiceTests.self).url(forResource: "DetailsMock.json", withExtension: nil)!
        let data = try! Data(contentsOf: file)
        let json = try! decoder.decode(PlaceDetailsResponse.self, from: data)
        completion(.success(json.result))
    }
}
