//
//  String+SoftUnwrap.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var valid: String {
        return self ?? ""
    }
}
