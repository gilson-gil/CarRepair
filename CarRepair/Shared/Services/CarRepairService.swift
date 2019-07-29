//
//  CarRepairService.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum CarRepairServiceError: LocalizedError {
    case endReached
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .custom(let message):
            return message
        default:
            return localizedDescription
        }
    }
}

enum CarRepairService {
    case list(Location)
    case nextPage(String)
    case details(String)
}

extension CarRepairService: Service {
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com")!
    }

    var path: String {
        switch self {
        case .list, .nextPage:
            return "/maps/api/place/nearbysearch/json"
        case .details:
            return "/maps/api/place/details/json"
        }
    }

    var method: Method {
        return .get
    }

    var parameters: Parameters? {
        switch self {
        case .list(let location):
            return PlaceRequest(location: location, types: "car_repair").parameters
        case .nextPage(let token):
            return PlaceNextPageRequest(pagetoken: token).parameters
        case .details(let placeId):
            return PlaceDetailsRequest(placeId: placeId).parameters
        }
    }
}
