//
//  CustomTabBarController.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 11/2/20.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        
        let newsNavigationController = makeNavigationController(customViewController: NewsViewController(), title: "News", image: #imageLiteral(resourceName: "news"))
        
        let casesNavigationController = makeNavigationController(customViewController: CasesViewController(), title: "Cases", image: #imageLiteral(resourceName: "cases"))
        
        let profileNavigationController = makeNavigationController(customViewController: ProfileViewController(), title: "Profile", image: #imageLiteral(resourceName: "profile"))

        viewControllers = [newsNavigationController, casesNavigationController, profileNavigationController]
    }
    
    fileprivate func makeNavigationController(customViewController: UIViewController, title: String, image: UIImage) -> UINavigationController{
        customViewController.navigationItem.title = title
        let customNavigationController  = UINavigationController(rootViewController: customViewController)
        customViewController.title = title
        customViewController.tabBarItem.image = image
        return customNavigationController
    }

}
