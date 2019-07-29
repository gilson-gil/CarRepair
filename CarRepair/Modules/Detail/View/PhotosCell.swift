//
//  PhotosCell.swift
//  CarRepair
//
//  Created by Gilson Gil on 28/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

final class PhotosCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(.init(nibName: PhotoCell.reuseIdentifier, bundle: nil),
                                    forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!

    var viewModel: PhotosCellViewModel?
}

// MARK: - UICollectionView DataSource
extension PhotosCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.placePhotos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let configurator = viewModel?.photoConfigurators[indexPath.item] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.update(cell)
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension PhotosCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

// MARK: - UIScrollView Delegate
extension PhotosCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        pageControl.currentPage = page
    }
}

extension PhotosCell: Updatable {
    func update(_ viewModel: PhotosCellViewModel) {
        self.viewModel = viewModel
        collectionView.isHidden = viewModel.placePhotos.isEmpty
        collectionView.reloadData()
        pageControl.numberOfPages = viewModel.placePhotos.count
        pageControl.currentPage = 0
    }
}
