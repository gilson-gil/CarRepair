//
//  PhotoService.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum PhotoServiceError: LocalizedError {
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message
        }
    }
}

enum PhotoService {
    case download(String)
}

extension PhotoService: Service {
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com")!
    }

    var path: String {
        switch self {
        case .download:
            return "/maps/api/place/photo"
        }
    }

    var method: Method {
        return .get
    }

    var parameters: Parameters? {
        switch self {
        case .download(let reference):
            return PhotoRequest(reference: reference).parameters
        }
    }
}
