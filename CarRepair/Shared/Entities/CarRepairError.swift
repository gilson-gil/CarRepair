//
//  CarRepairError.swift
//  CarRepair
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum CarRepairError: LocalizedError {
    case httpError(HTTPError)
    case carRepairRepositoryError(CarRepairRepositoryError)

    var localizedDescription: String {
        switch self {
        case .httpError(let error):
            return error.localizedDescription
        case .carRepairRepositoryError(let error):
            return error.localizedDescription
        }
    }
}
