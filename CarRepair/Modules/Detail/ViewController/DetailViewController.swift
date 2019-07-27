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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.layer.cornerRadius = 8
        }
    }

    var locationManager: CLLocationManager = .init()
    var viewModel: DetailViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    func updateUI() {
        navigationItem.title = viewModel.placeName
        collectionView.isHidden = viewModel.placePhotos.isEmpty
        addressLabel.text = viewModel.placeAddress
        let distance: Double?
        let placeLocation = viewModel.placeLocation
        if let location = locationManager.location {
            distance = location.distance(from: .init(latitude: placeLocation.latitude,
                                                     longitude: placeLocation.longitude))
        } else {
            distance = nil
        }
        let distanceString: String = DistanceFormatter().format(value: distance)
        distanceLabel.text = distanceString
        let center: CLLocationCoordinate2D = .init(latitude: placeLocation.latitude, longitude: placeLocation.longitude)
        let span: MKCoordinateSpan = .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        mapView.region = .init(center: center, span: span)
        mapView.addAnnotations([viewModel.place])
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

// MARK: - UICollectionView DataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.placePhotos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = viewModel.photoConfigurators[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.update(cell)
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

// MARK: - MKMapView Delegate
extension DetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        presentDirections()
        mapView.deselectAnnotation(view.annotation, animated: true)
    }
}
