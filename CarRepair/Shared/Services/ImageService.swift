//
//  ImageService.swift
//  CarRepair
//
//  Created by Gilson Gil on 24/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum ImageServiceError: LocalizedError {
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message
        }
    }
}

enum ImageService {
    case download(String)
}

extension ImageService: Service {
    var baseURL: URL {
        switch self {
        case .download(let urlString):
            let url = URL(string: urlString) ?? URL(fileURLWithPath: "")
            return url.baseURL ?? url
        }
    }

    var path: String {
        switch self {
        case .download(let urlString):
            let url = URL(string: urlString) ?? URL(fileURLWithPath: "")
            return url.path
        }
    }

    var method: Method {
        return .get
    }

    var parameters: Parameters? {
        return nil
    }
}
