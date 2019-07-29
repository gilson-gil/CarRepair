//
//  LoadingState.swift
//  CarRepair
//
//  Created by Gilson Gil on 23/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum LoadingState {
    case stopped
    case loading
    case success
    case failure(Error)
}

extension LoadingState: Equatable {
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.stopped, .stopped), (.loading, .loading), (.failure, .failure), (.success, .success):
            return true
        default:
            return false
        }
    }
}
