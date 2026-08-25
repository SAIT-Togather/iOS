//
//  Util.swift
//  SAIT
//
//  Created by 이머영 on 8/25/26.
//

import Foundation
import UIKit

class Util {
    
    static func showAlert(
        on viewController: UIViewController,
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let confirmAction = UIAlertAction(
            title: "확인",
            style: .default
        )
        
        alert.addAction(confirmAction)
        
        viewController.present(
            alert,
            animated: true
        )
    }
    
}
