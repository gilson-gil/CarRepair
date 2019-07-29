//
//  ImageServiceTests.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import Quick
import Nimble

final class ImageServiceTests: QuickSpec {
    override func spec() {
        describe("given a image service") {
            let sut = ImageService.download("https://www.google.com")
            context("with a url of https://www.google.com") {
                it("should have no query url parameters") {
                    expect(sut.parameters?.getEncoded).to(beNil())
                }
            }
        }
    }
}
