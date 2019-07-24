//
//  DistanceFormatter.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct DistanceFormatter {
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.locale = Locale(identifier: "pt-BR")
        return formatter
    }()

    func format(value: Double?) -> String {
        if let value = value {
            if value < 1000 {
                return formatter.string(from: .init(value: value)).valid + " m"
            } else {
                return formatter.string(from: .init(value: value / 1000)).valid + " km"
            }
        } else {
            return "-- km"
        }
    }
}
