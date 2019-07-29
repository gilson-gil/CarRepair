//
//  ListViewModelTests.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import CoreLocation
import Quick
import Nimble

final class ListViewModelTests: QuickSpec {
    override func spec() {
        let sut = ListViewModel(repository: CarRepairMockRepository(), imageRepository: ImageMockRepository())
        describe("given a list view model") {
            context("when fetches first page with location") {
                let location = Location.init(location: CLLocation(latitude: -23, longitude: -46))
                sut.fetchFirstPage(location: location) { result in }
                it("should eventually have places to show") {
                    expect(sut.getNumberOfRows()).toEventually(beGreaterThan(0))
                    expect(sut.getPlace(at: IndexPath(row: 0, section: 0))).toEventuallyNot(beNil())
                    expect(sut.placeResponse).toEventuallyNot(beNil())
                }
            }

            context("when fetches a next page") {
                let previousePages = sut.getNumberOfRows()
                sut.fetchNextPage {}
                it("should eventually have more places to show") {
                    expect(sut.getNumberOfRows()).toEventually(beGreaterThan(previousePages))
                    expect(sut.getConfigurator(at: IndexPath(row: 0, section: 0)).reuseIdentifier).toEventually(equal(ListItemCell.reuseIdentifier))
                }
            }
        }
    }
}
