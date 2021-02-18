//
//  MapViewController.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 22.12.20.
//
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    let mapView =  MKMapView()
    let locationManager = CLLocationManager()
    let locationTextField = UITextField()
    var homeLocation = CLLocation()
    let annotation = MKPointAnnotation() //Description of point
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save location", style: .plain, target: self, action: #selector(savePositionTapped))
    
    mapView.frame = CGRect(x: self.view.frame.minX, y: 0.2*self.view.frame.height, width: self.view.frame.width, height: 0.8*self.view.frame.height)
    self.view.addSubview(mapView)
    
    locationTextField.frame = CGRect(x: self.view.frame.minX+10, y: mapView.frame.minY-45, width: self.view.frame.width-15, height: 35)
    locationTextField.placeholder = "Print your address"
    locationTextField.borderStyle = UITextField.BorderStyle.roundedRect
    locationTextField.keyboardType = UIKeyboardType.default
    locationTextField.returnKeyType = UIReturnKeyType.done
    locationTextField.clearButtonMode = UITextField.ViewMode.whileEditing
    locationTextField.font = UIFont.boldSystemFont(ofSize: 21)
    locationTextField.addTarget(self, action: #selector(locationTextFieldEdit), for: .editingChanged)
    self.view.addSubview(locationTextField)
    
    
    
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        locationManager.delegate = self
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

       // mapView.showsUserLocation = true
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
  }
  
    @objc func savePositionTapped(){
        let encodedLocation = NSKeyedArchiver.archivedData(withRootObject: homeLocation)
        UserDefaults.standard.set(encodedLocation, forKey: "savedLocation")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func locationTextFieldEdit(){
        let geocoder = CLGeocoder()
        if let address = locationTextField.text {
    
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if error != nil {
                } else if let placemarks = placemarks {

                  if let coordinate = placemarks.first?.location?.coordinate {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "Home"
                    annotation.subtitle = "Home"
                    self.mapView.addAnnotation(annotation)

                    //centerMap(locValue)
                
                      self.mapView.setCenter(coordinate, animated: true)
                  }
                  }
                }
        
        }
          
        }
        

    

    

   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        homeLocation = manager.location!
        let locValue:CLLocationCoordinate2D = homeLocation.coordinate

        mapView.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
       // mapView.removeAnnotation(annotation as Data)
        annotation.coordinate = locValue
        annotation.title = "Home"
     //   annotation.subtitle = "Home"
        mapView.addAnnotation(annotation)
        
    }
}
