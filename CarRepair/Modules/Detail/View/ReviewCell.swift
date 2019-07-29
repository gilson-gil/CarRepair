//
//  ReviewCell.swift
//  CarRepair
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ReviewCell: UITableViewCell {
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timePastLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
}

// MARK: - Updatable
extension ReviewCell: Updatable {
    func update(_ viewModel: ReviewCellViewModel) {
        viewModel.imageRepository.getImage(url: viewModel.authorImageUrl) { [weak authorImageView] result in
            DispatchQueue.main.async {
                authorImageView?.image = try? result.get()
            }
        }
        authorLabel.text = viewModel.authorName
        timePastLabel.text = viewModel.timePast
        reviewLabel.text = viewModel.text
    }
}
