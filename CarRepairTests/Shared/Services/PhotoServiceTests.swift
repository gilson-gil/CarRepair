//
//  PhotoServiceTests.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import Quick
import Nimble

final class PhotoServiceTests: QuickSpec {
    override func spec() {
        describe("given a photo service") {
            let sut = PhotoService.download("h7f83h91")
            context("with a reference of h7f83h91") {
                it("should have query url parameters") {
                    expect(sut.parameters?.getEncoded).toNot(beNil())
                }
                it("should have photoreference parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "photoreference" })?.value == "h7f83h91")
                        .to(beTrue())
                }
                it("should have maxwidth parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "maxwidth" })?.value == "400")
                        .to(beTrue())
                }
                it("should have key parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "key" })?.value == Constants.googlePlacesAPIKey.rawValue)
                        .to(beTrue())
                }
            }
        }
    }
}
