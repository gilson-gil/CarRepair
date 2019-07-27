//
//  PhotoCellViewModel.swift
//  CarRepair
//
//  Created by Gilson Gil on 25/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class PhotoCellViewModel {
    let photo: Photo
    var repository: PhotoRepository

    init(photo: Photo, repository: PhotoRepository) {
        self.photo = photo
        self.repository = repository
    }

    func getImageData(completion: @escaping (UIImage?) -> Void) {
        repository.getImage(with: photo.photoReference) { result in
            completion(try? result.get())
        }
    }
}
