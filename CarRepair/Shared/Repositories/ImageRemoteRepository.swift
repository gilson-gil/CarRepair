//
//  ImageRemoteRepository.swift
//  CarRepair
//
//  Created by Gilson Gil on 24/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ImageRemoteRepository: ImageRepository {
    let engine: NetworkEngine<ImageService> = .init()

    private let cache = NSCache<NSString, UIImage>()

    func getImage(url: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void) {
        if let cached = cache.object(forKey: url as NSString) {
            return completion(.success(cached))
        }
        download(url: url, completion: completion)
    }

    func download(url: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void) {
        engine.requestData(target: ImageService.download(url)) { (result: Result<Data, HTTPError>) in
            guard case let .success(data) = result else { return completion(.failure(.httpError(.unknown))) }
            guard let image = UIImage(data: data) else { return completion(.failure(.httpError(.unknown))) }
            self.cache.setObject(image, forKey: url as NSString)
            completion(.success(image))
        }
    }
}
