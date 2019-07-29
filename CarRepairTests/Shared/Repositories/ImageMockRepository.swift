//
//  ImageMockRepository.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import UIKit

struct ImageMockRepository: ImageRepository {
    func getImage(url: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void) {
        if url == "test_image" {
            completion(.success(UIImage()))
        } else {
            completion(.failure(.httpError(.unknown)))
        }
    }

    func download(url: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void) {
        if url == "test_image" {
            completion(.success(UIImage()))
        } else {
            completion(.failure(.httpError(.unknown)))
        }
    }
}
