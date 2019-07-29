//
//  RequestFactoryTests.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import Quick
import Nimble

final class RequestFactoryTests: QuickSpec {
    override func spec() {
        let sut = RequestFactory.self
        let urlString = "https://www.google.com/search"
        let url = URL(string: "search", relativeTo: URL(string: "https://www.google.com"))
        let baseUrl = url!.baseURL!
        let path = url!.path
        describe("given a request factory") {
            context("when it create a simple url request") {
                let result = sut.create(method: .get, urlString: urlString)
                it("should create valid urlrequest") {
                    expect(result.get).toNot(throwError())
                    expect(try? result.get().url?.absoluteString).to(equal(urlString))
                }
            }

            context("when it create a base url request") {
                let result = sut.create(method: .get, baseUrl: baseUrl, path: path)
                it("should create valid urlrequest") {
                    expect(result.get).toNot(throwError())
                    expect(try? result.get().url?.absoluteString).to(equal(urlString))
                }
            }

            context("when it create a complex url request") {
                let result = sut.create(method: .get, baseUrl: baseUrl, path: path, parameters: ["q": "youse"])
                it("should create valid urlrequest") {
                    expect(result.get).toNot(throwError())
                    expect(try? result.get().url?.absoluteString).to(equal(urlString + "?q=youse"))
                    expect(try? result.get().url?.query).to(equal("q=youse"))
                }
            }
        }
    }
}
