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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.addSubview(refreshControl)
        }
    }
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var loadingView: UIView!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshChanged), for: .valueChanged)
        return refreshControl
    }()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }

    func askLocation() {
        locationManager.requestWhenInUseAuthorization()
    }

    func fetchFirstPage(cllocation: CLLocation?, forceRefresh: Bool) {
        let location = Location(location: cllocation)
        startLoading()
        viewModel.fetchFirstPage(location: location, forceRefresh: forceRefresh) { [weak self] shouldUpdate in
            self?.stopLoading()
            guard shouldUpdate else { return }
            self?.updateUI()
        }
    }

    func fetchNextPage() {
        viewModel.fetchNextPage { [weak self] in
            self?.updateUI()
        }
    }

    func startLoading() {
        DispatchQueue.main.async {
            self.tableView.backgroundView = self.loadingView
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.tableView.backgroundView = nil
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

    @objc
    func refreshChanged() {
        fetchFirstPage(cllocation: locationManager.location, forceRefresh: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if let detailViewController = segue.destination as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let place = viewModel.getPlace(at: indexPath) {
            detailViewController.viewModel = DetailViewModel(place: place,
                                                             repository: PhotoRemoteRepository(),
                                                             imageRepository: ImageRemoteRepository())
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
            self.fetchFirstPage(cllocation: manager.location ?? locations.first, forceRefresh: false)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
