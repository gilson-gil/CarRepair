//
//  ImageRepository.swift
//  CarRepair
//
//  Created by Gilson Gil on 24/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol ImageRepository {
    func getImage(url: String, completion: @escaping (Result<UIImage, HTTPError>) -> Void)
    func download(url: String, completion: @escaping (Result<UIImage, HTTPError>) -> Void)
}
