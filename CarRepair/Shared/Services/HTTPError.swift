//
//  HTTPError.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum HTTPError: LocalizedError {
    case noInternet
    case invalidURL
    case invalidJSON
    case urlError(URLError)
    case unknown

    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "Parece que você está sem internet, tente novamente mais tarde"
        case .invalidURL:
            return "URL inválida"
        case .invalidJSON:
            return "BAD JSON"
        case .urlError(let error):
            return error.localizedDescription
        case .unknown:
            return "Erro desconhecido"
        }
    }
}
