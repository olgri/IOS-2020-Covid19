//
//  ProfileViewController.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 11/2/20.
//

import UIKit

class ProfileViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add mainView on Screen
        self.title = "Profile"
        self.view.backgroundColor = .white
        //addButton
        let logoutButton = UIButton(frame: CGRect(x: 160, y: 568, width: 57, height: 26))
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(userTryToLogout), for: .touchUpInside)
        self.view.addSubview(logoutButton)
        
        //SetRegion control
        //addButton
        let setRegionButton = UIButton(frame: CGRect(x: 160, y: 460, width: 57, height: 26))
        setRegionButton.setTitleColor(.red, for: .normal)
        setRegionButton.setTitle("Choose region", for: .normal)
        setRegionButton.addTarget(self, action: #selector(userTryToGetCurrentLocationFromMap), for: .touchUpInside)
        self.view.addSubview(setRegionButton)
             
    }
    @objc func userTryToLogout(){
        self.navigationController?.tabBarController?.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func userTryToGetCurrentLocationFromMap(){
        self.navigationController?.pushViewController(MapViewController(), animated: true)
    }

}
