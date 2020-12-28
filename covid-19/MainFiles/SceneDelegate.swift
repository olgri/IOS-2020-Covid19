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
import NotificationCenter

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    static let geoCoder = CLGeocoder()
    let center = UNUserNotificationCenter.current()
    let locationManager = CLLocationManager()
    var homeLocation = CLLocation()
  //  var notificationAccessGranted = false
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let loginViewController = LoginViewController()
        let loginNavigationViewController = CustomNavigationController(rootViewController: loginViewController)
        window.rootViewController = loginNavigationViewController// Your initial view controller.
        window.makeKeyAndVisible()
        self.window = window
        
        
        //MARK: LocationAuthorisation
        if userGrantAccessAppToNotifications() {
            print("!!!!!!!!!!!!!!!Получено разрешение на отправку уведомлений!")
        }
        if userGrantAccessAppToLocation() {
            locationManager.startUpdatingLocation()
        }
        locationManager.delegate = self
        center.delegate = self
        
   
        
        //MARK: Try to get saved Location
        
        if let previousLocationEncoded = UserDefaults.standard.object(forKey: "savedLocation") as? Data {
        let previousLocationDecoded = NSKeyedUnarchiver.unarchiveObject(with: previousLocationEncoded) as! CLLocation
            homeLocation = previousLocationDecoded
           // locationManager.startMonitoring(for: CLCircularRegion(center: homeLocation.coordinate, radius: 100, identifier: "Home area"))
        print("!!!!!!!!!!!!!!!!!!!!!\(homeLocation)")
            // Define the content of the notification
          
          //  content.sound = UNNotificationSound(named: ")

            // Define the region
            let region = CLCircularRegion(center: homeLocation.coordinate, radius: 100, identifier: "Home region")
            region.notifyOnEntry = false
            region.notifyOnExit = true
            locationManager.startMonitoring(for: region)
        }
        
    }

    func userGrantAccessAppToNotifications() -> Bool{
        var accessGranted = false
        center.requestAuthorization(options: [.alert, .sound]) {
                    (accepted, error) in
                    accessGranted = accepted
            }
        return accessGranted
        
    }
    
    func userGrantAccessAppToLocation() -> Bool{
        locationManager.requestWhenInUseAuthorization()
        return true
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

