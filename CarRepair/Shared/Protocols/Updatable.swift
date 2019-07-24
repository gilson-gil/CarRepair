//
//  Updatable.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol Updatable: class {
    associatedtype ViewModel

    func update(_ viewModel: ViewModel)
}

struct CellConfigurator<Cell> where Cell: Updatable & ReuseIdentifiable {
    let viewModel: Cell.ViewModel
    var cellClass: AnyClass { return Cell.self }
    var reuseIdentifier: String { return Cell.reuseIdentifier }

    func update(_ cell: UITableViewCell) {
        if let cell = cell as? Cell {
            cell.update(viewModel)
        }
    }

    func register(_ tableView: UITableView?) {
        tableView?.register(cellClass, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
}

protocol CellConfiguratorType {
    var cellClass: AnyClass { get }
    var reuseIdentifier: String { get }

    func update(_ cell: UITableViewCell)
    func register(_ tableView: UITableView?)
}

extension CellConfigurator: CellConfiguratorType {}

extension UITableView {
    func register(_ configurators: [CellConfiguratorType?]?) {
        configurators?.forEach {
            $0?.register(self)
        }
    }
}
