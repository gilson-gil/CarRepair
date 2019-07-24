//
//  ListViewController.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import CoreLocation
import UIKit

final class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!

    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    var viewModel: ListViewModel = ListViewModel(repository: CarRepairRemoteRepository(),
                                                 imageRepository: ImageRemoteRepository())

    override func viewDidLoad() {
        super.viewDidLoad()
        askLocation()
    }

    func askLocation() {
        locationManager.requestWhenInUseAuthorization()
    }

    func fetchFirstPage(cllocation: CLLocation?) {
        let location = Location(location: cllocation)
        viewModel.fetchFirstPage(location: location) { [weak self] in
            self?.updateUI()
        }
    }

    func fetchNextPage() {
        viewModel.fetchNextPage { [weak self] newRange in
            guard let range = newRange else { return }
            self?.updateUI(with: range)
        }
    }

    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.viewModel.cellConfigurators.isEmpty, case .failure = self.viewModel.state {
                self.tableView.backgroundView = self.emptyView
            } else {
                self.tableView.backgroundView = nil
            }
        }
    }

    func updateUI(with range: Range<Int>) {
        DispatchQueue.main.async {
            let indexPaths = range.map { IndexPath(row: $0, section: 0) }
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}

// MARK: - UITableView DataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = viewModel.getConfigurator(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.update(cell)
        return cell
    }
}

// MARK: - UITableView Delegate
extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            fetchNextPage()
        }
    }
}

// MARK: - CLLocationManager Delegate
extension ListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status != .denied else { return }
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.fetchFirstPage(cllocation: manager.location ?? locations.first)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
