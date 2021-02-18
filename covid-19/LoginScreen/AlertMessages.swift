//
//  AlertMessages.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 29.01.21.
//

import UIKit

class Messages {
    
    func showAlertMsg(title: String, message: String, viewController: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alertController, animated: true, completion: nil)
    }
}

