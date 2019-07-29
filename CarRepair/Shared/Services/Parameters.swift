//
//  Parameters.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

extension Parameters {
    var getEncoded: [URLQueryItem] {
        var items: [URLQueryItem] = []
        for (key, value) in self {
            let item = URLQueryItem(name: key, value: String(describing: value))
            items.append(item)
        }
        return items
    }
}

extension Encodable {
    var parameters: Parameters? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let parameters = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Parameters
        return parameters
    }
}
