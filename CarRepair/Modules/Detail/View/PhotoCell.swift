//
//  PhotoCell.swift
//  CarRepair
//
//  Created by Gilson Gil on 25/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
}

extension PhotoCell: Updatable {
    func update(_ viewModel: PhotoCellViewModel) {
        viewModel.getImageData { [weak self] image in
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }
    }
}
