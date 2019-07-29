//
//  PhotoMockRepository.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import UIKit

struct PhotoMockRepository: PhotoRepository {
    func getImage(with reference: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void) {
        if reference == "test_image" {
            completion(.success(UIImage()))
        } else {
            completion(.failure(.httpError(.unknown)))
        }
    }

    func download(with reference: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void) {
        if reference == "test_image" {
            completion(.success(UIImage()))
        } else {
            completion(.failure(.httpError(.unknown)))
        }
    }
}
