//
//  SceneDelegate.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 10/31/20.


import UIKit
import CoreLocation
import UserNotifications
import NotificationCenter

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
  //  var notificationAccessGranted = false
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let loginViewController = LoginViewController(validation: ValidationService())
        let loginNavigationViewController = CustomNavigationController(rootViewController: loginViewController)
        window.rootViewController = loginNavigationViewController// Your initial view controller.
        window.makeKeyAndVisible()
        self.window = window
        
        
        //MARK: LocationAuthorisation and NotificationAuthorization and delegate methods
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {(accepted, error) in }
        notificationCenter.delegate = self
        
   
        
        //MARK: Try to load saved Home location from UserDefaults
        if let previousLocationEncoded = UserDefaults.standard.object(forKey: "savedLocation") as? Data {
        let homeLocation = NSKeyedUnarchiver.unarchiveObject(with: previousLocationEncoded) as! CLLocation
            
        //MARK: Define region and notification properties
        let region = CLCircularRegion(center: homeLocation.coordinate, radius: 100, identifier: "Home region")
        region.notifyOnEntry = false
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
        }
    }


    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion){
        showNotification()
    }
    
    func showNotification () {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "#STAYONLINE"
        notificationContent.body = "Don't forget antiseptic and mask!!!"
        notificationContent.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "myId",
                                            content: notificationContent,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("ошибка с запросом: \(error)")
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}

