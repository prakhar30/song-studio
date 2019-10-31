//
//  UIVIewController.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 01/11/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayPopup(title: String, message: String, completionHandler: @escaping () -> Void) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            completionHandler()
        })
        alertMessage.addAction(dismiss)
        self.present(alertMessage, animated: true, completion: nil)
    }
}
