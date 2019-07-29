//
//  DetailViewModelTests.swift
//  CarRepairTests
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

@testable import CarRepair

import Quick
import Nimble

final class DetailViewModelTests: QuickSpec {
    override func spec() {
        let carRepairRepository = CarRepairMockRepository()
        let place = carRepairRepository.getMockPlace()
        let sut = DetailViewModel(place: place,
                                  location: place.location,
                                  repository: carRepairRepository,
                                  photoRepository: PhotoMockRepository(),
                                  imageRepository: ImageMockRepository())
        describe("given a detail view model") {
            context("when fetches place details") {
                sut.fetchDetails {}
                it("should eventually have more photos to show") {
                    expect(sut.configurator(at: IndexPath(row: 0, section: 0))).toEventually(beAKindOf(CellConfigurator<PhotosCell>.self))
                    expect((sut.configurator(at: IndexPath(row: 0, section: 0)) as! CellConfigurator<PhotosCell>).viewModel.placePhotos.count).toEventually(beGreaterThan(1))
                }

                it("should have details") {
                    expect(sut.numberOfRows(at: 0)).toEventually(beGreaterThan(0))
                    expect(sut.numberOfSections).toEventually(beGreaterThan(0))
                    expect(sut.placeName).to(equal("Dj Freios"))
                }
            }
        }
    }
}
