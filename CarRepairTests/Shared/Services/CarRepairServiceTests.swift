//
//  CarRepairServiceTests.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import CoreLocation
import Quick
import Nimble

final class CarRepairServiceTests: QuickSpec {
    override func spec() {
        describe("given a car repair service of type list") {
            let sut = CarRepairService.list(Location(location: CLLocation(latitude: -23, longitude: -46))!)
            context("with a location coordinates -23,-46") {
                it("should have query url parameters") {
                    expect(sut.parameters?.getEncoded).toNot(beNil())
                }
                it("should have location parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "location" })?.value == "-23.0,-46.0")
                        .to(beTrue())
                }
                it("should have rankby parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "rankby" })?.value == "distance")
                        .to(beTrue())
                }
                it("should have types parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "types" })?.value == "car_repair")
                        .to(beTrue())
                }
                it("should have key parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "key" })?.value == Constants.googlePlacesAPIKey.rawValue)
                        .to(beTrue())
                }
            }
        }

        describe("given a car repair service of type next page") {
            let sut = CarRepairService.nextPage("637281")
            context("with a page token of 637281") {
                it("should have query url parameters") {
                    expect(sut.parameters?.getEncoded).toNot(beNil())
                }
                it("should have pagetoken parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "pagetoken" })?.value == "637281")
                        .to(beTrue())
                }
                it("should have key parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "key" })?.value == Constants.googlePlacesAPIKey.rawValue)
                        .to(beTrue())
                }
            }
        }

        describe("given a car repair service of type details") {
            let sut = CarRepairService.details("gftrtygu")
            context("with a placeid of gftrtygu") {
                it("should have query url parameters") {
                    expect(sut.parameters?.getEncoded).toNot(beNil())
                }
                it("should have placeid parameter of correct value") {
                    expect(sut.parameters?.getEncoded
                        .first(where: { $0.name == "placeid" })?.value == "gftrtygu")
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
