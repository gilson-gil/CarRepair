//
//  PhotoRemoteRepository.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class PhotoRemoteRepository: PhotoRepository {
    let engine: NetworkEngine<PhotoService> = .init()

    private let cache = NSCache<NSString, UIImage>()

    func getImage(with reference: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void) {
        if let cached = cache.object(forKey: reference as NSString) {
            return completion(.success(cached))
        }
        download(with: reference, completion: completion)
    }

    func download(with reference: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void) {
        engine.requestData(target: PhotoService.download(reference)) { (result: Result<Data, HTTPError>) in
            guard case let .success(data) = result else { return completion(.failure(.httpError(.unknown))) }
            guard let image = UIImage(data: data) else { return completion(.failure(.httpError(.unknown))) }
            self.cache.setObject(image, forKey: reference as NSString)
            completion(.success(image))
        }
    }
}
