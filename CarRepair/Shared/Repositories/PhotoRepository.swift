//
//  PhotoRepository.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol PhotoRepository {
    func getImage(with reference: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void)
    func download(with reference: String, completion: @escaping (Result<UIImage, CarRepairError>) -> Void)
}
