//
//  ListItemCell.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class ListItemCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
}

extension ListItemCell: Updatable {
    func update(_ viewModel: ListItemCellViewModel) {
        iconImageView.image = nil
        viewModel.imageRepository.getImage(url: viewModel.iconURL) { [weak self] result in
            DispatchQueue.main.async {
                self?.iconImageView.image = (try? result.get())?.withRenderingMode(.alwaysTemplate)
            }
        }
        nameLabel.text = viewModel.name
        openView.backgroundColor = viewModel.isOpen ? .green : .red
        distanceLabel.text = viewModel.distance
        addressLabel.text = viewModel.address
    }
}
