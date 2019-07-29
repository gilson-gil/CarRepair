//
//  MapCell.swift
//  CarRepair
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import MapKit
import UIKit

protocol MapCellDelegate: class {
    func didTapPresentDirections(at cell: MapCell)
}

final class MapCell: UITableViewCell {
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.layer.cornerRadius = 8
        }
    }

    weak var delegate: MapCellDelegate?
}

// MARK: - Updatable
extension MapCell: Updatable {
    func update(_ viewModel: MapCellViewModel) {
        let center: CLLocationCoordinate2D = .init(latitude: viewModel.placeLocation.latitude,
                                                   longitude: viewModel.placeLocation.longitude)
        let span: MKCoordinateSpan = .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        mapView.region = .init(center: center, span: span)
        mapView.addAnnotations([viewModel.place])
    }
}

// MARK: - MKMapView Delegate
extension MapCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        delegate?.didTapPresentDirections(at: self)
        mapView.deselectAnnotation(view.annotation, animated: true)
    }
}
