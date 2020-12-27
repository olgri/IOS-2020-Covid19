//
//  CustomNavigationController.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 11/1/20.
//

import UIKit

class CustomNavigationController: UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarHidden(true, animated: false)
    }

}
