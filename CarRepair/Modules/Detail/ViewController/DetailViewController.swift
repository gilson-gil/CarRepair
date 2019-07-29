//
//  DetailViewController.swift
//  CarRepair
//
//  Created by Gilson Gil on 25/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var locationManager: CLLocationManager = .init()
    var viewModel: DetailViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        viewModel.fetchDetails { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }

    func updateUI() {
        navigationItem.title = viewModel.placeName
        viewModel.configurators.forEach(tableView.register)
        tableView.reloadData()
        viewModel.getIconImage { [weak navigationItem] image in
            DispatchQueue.main.async {
                let imageView = UIImageView(image: image?.withRenderingMode(.alwaysTemplate))
                imageView.tintColor = .white
                imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                imageView.contentMode = .scaleAspectFit
                navigationItem?.rightBarButtonItems = [.init(customView: imageView)]
            }
        }
    }

    func presentDirections() {
        let apps = viewModel.availableApps()
        guard !apps.isEmpty else { return }
        let alert = UIAlertController(title: "Escolha um app", message: nil, preferredStyle: .actionSheet)
        apps.forEach { app in
            let action: UIAlertAction = .init(title: app.title, style: .default) { [weak self] action in
                guard let self = self else { return }
                app.goTo(place: self.viewModel.place)
            }
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableView DataSource
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = viewModel.configurator(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.update(cell)
        if let mapCell = cell as? MapCell {
            mapCell.delegate = self
        }
        return cell
    }
}

// MARK: - MapCell Delegate
extension DetailViewController: MapCellDelegate {
    func didTapPresentDirections(at cell: MapCell) {
        presentDirections()
    }
}
