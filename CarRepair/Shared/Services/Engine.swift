//
//  Engine.swift
//  CarRepair
//
//  Created by Gilson Gil on 22/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

final class NetworkEngine<Target: Service> {
    private var tasks: [URLSessionDataTask] = []

    init() {}

    func request<T: Decodable>(target: Target,
                               decoder: JSONDecoder = JSONDecoder(),
                               completion: @escaping(Result<T?, HTTPError>) -> Void) {
        let requestResult = RequestFactory.create(method: target.method,
                                                  baseUrl: target.baseURL,
                                                  path: target.path,
                                                  parameters: target.parameters)
        guard case let .success(request) = requestResult else {
            if case let .failure(error) = requestResult {
                return completion(.failure(error))
            } else {
                return completion(.failure(.unknown))
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            debugPrint("--- [REQUEST] \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")
            debugPrint("--- [HEADER] \(request.allHTTPHeaderFields ?? [:])")
            if let body = request.httpBody {
                debugPrint("--- [BODY] \(String(data: body, encoding: String.Encoding.utf8) ?? "")")
            }
            if let status = (response as? HTTPURLResponse)?.statusCode {
                debugPrint("--- [STATUS] \(status)")
            }

            if let urlError = error as? URLError {
                return completion(.failure(.urlError(urlError)))
            }
            guard error == nil else { return completion(.failure(.unknown)) }
            guard let data = data else { return completion(.success(nil)) }
            do {
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidJSON))
            }
        }
        task.resume()
        tasks.append(task)
    }

    func requestData(target: Target, completion: @escaping(Result<Data, HTTPError>) -> Void) {
        let requestResult = RequestFactory.create(method: target.method,
                                                  baseUrl: target.baseURL,
                                                  path: target.path,
                                                  parameters: target.parameters)
        guard case let .success(request) = requestResult else {
            if case let .failure(error) = requestResult {
                return completion(.failure(error))
            } else {
                return completion(.failure(.unknown))
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            debugPrint("--- [REQUEST] \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")
            debugPrint("--- [HEADER] \(request.allHTTPHeaderFields ?? [:])")
            if let body = request.httpBody {
                debugPrint("--- [BODY] \(String(data: body, encoding: String.Encoding.utf8) ?? "")")
            }
            if let status = (response as? HTTPURLResponse)?.statusCode {
                debugPrint("--- [STATUS] \(status)")
            }

            if let urlError = error as? URLError {
                return completion(.failure(.urlError(urlError)))
            }
            guard error == nil else { return completion(.failure(.unknown)) }
            completion(.success(data ?? Data()))
        }
        task.resume()
        tasks.append(task)
    }
}
