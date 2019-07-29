//
//  RequestFactory.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct RequestFactory {
    static func create(method: Method, urlString: String) -> Result<URLRequest, HTTPError> {
        guard let url: URL = URL(string: urlString) else { return .failure(.invalidURL) }
        var urlRequest: URLRequest = .init(url: url)
        urlRequest.httpMethod = method.rawValue
        return .success(urlRequest)
    }

    static func create(method: Method, baseUrl: URL, path: String) -> Result<URLRequest, HTTPError> {
        let parameters: Parameters? = nil
        return create(method: method, baseUrl: baseUrl, path: path, parameters: parameters)
    }

    static func create(method: Method,
                       baseUrl: URL,
                       path: String,
                       parameters: Parameters? = nil) -> Result<URLRequest, HTTPError> {
        guard var urlComponents: URLComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else {
            return .failure(.invalidURL)
        }
        urlComponents.path = path
        urlComponents.queryItems = parameters?.getEncoded

        guard let url: URL = urlComponents.url else { return .failure(.invalidURL) }
        var urlRequest: URLRequest = .init(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return .success(urlRequest)
    }
}
