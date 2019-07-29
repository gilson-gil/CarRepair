//
//  UIViewController+Alert.swift
//  CarRepair
//
//  Created by Gilson Gil on 29/07/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String?, message: String?, okTitle: String?, okCallback: (() -> Void)?, cancelTitle: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let okTitle = okTitle {
            let action = UIAlertAction(title: okTitle, style: .default) { _ in
                okCallback?()
            }
            alert.addAction(action)
        }
        if let cancelTitle = cancelTitle {
            let action = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
