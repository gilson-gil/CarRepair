//
//  Service.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

protocol Service {
    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var parameters: Parameters? { get }
}
