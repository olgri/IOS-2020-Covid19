//
//  SceneDelegate.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 10/31/20.
//
//AppMetrica key:0a9b83dc-c715-4a80-99df-090668126e88
import UIKit
import CoreLocation
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    static let geoCoder = CLGeocoder()
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    var homeLocation = CLLocation()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let loginViewController = LoginViewController()
        let loginNavigationViewController = CustomNavigationController(rootViewController: loginViewController)
        window.rootViewController = loginNavigationViewController// Your initial view controller.
        window.makeKeyAndVisible()
        self.window = window
        
        
        //MARK: LocationAuthorisation
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        }
        
        //MARK: Try to get saved Location
        
        if let previousLocationEncoded = UserDefaults.standard.object(forKey: "savedLocation") as? Data {
        let previousLocationDecoded = NSKeyedUnarchiver.unarchiveObject(with: previousLocationEncoded) as! CLLocation
            homeLocation = previousLocationDecoded
        }
            locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion){
        if homeLocation != nil {
            
        }
    }

}

