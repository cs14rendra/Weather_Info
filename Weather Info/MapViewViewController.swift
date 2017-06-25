//
//  MapViewViewController.swift
//  Weather Info
//
//  Created by surendra kumar on 6/25/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewViewController: UIViewController {
    
    // PROPERTY
    let  locationmanager = CLLocationManager()
    var marker : GMSMarker?
    var didFindLocation = false
    var mapView : GMSMapView?
    var isMarkerOnMap = false
    var currentLocation : CLLocation?{
        didSet{
            putMarker(position: CLLocationCoordinate2D(latitude: (self.currentLocation?.coordinate.latitude)!, longitude: (self.currentLocation?.coordinate.longitude)!))
        }
    }
    
    // LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationmanager.startUpdatingLocation()
        mapView = GMSMapView(frame: .zero)
        self.view = mapView
        mapView?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.requestAuthorization()
    }
    
    // UNWIND SEGUE
    @IBAction func c(s : UIStoryboardSegue){}
    
}


// FETCH WEATHE DATA
extension MapViewViewController {
    
    // Call only When user tapped Marker and about to move Next Screen
    func callweaher (location : CLLocation){
        let lat  : String = String(location.coordinate.latitude)
        let long : String = String(describing: location.coordinate.longitude)
        APIManager.sharedInstance.loadWeatherData(url: "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=82d316e8e5b1aaac532f77fea9e766b4")
    }
    
}


// HANDING ABOUT GOOGLE MAP AND MARKER
extension MapViewViewController : GMSMapViewDelegate {
    
     func putMarker(position : CLLocationCoordinate2D){
        guard !isMarkerOnMap else {return}
        isMarkerOnMap   = true
        marker          = GMSMarker(position: position)
        marker?.map     = self.mapView
        marker?.title   = "surendra"
        marker?.snippet = "kumar"
        marker?.isDraggable = true
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("Tapped")
        print(marker.position)
        //get marker Location
        currentLocation = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        // Call weather Data 
        callweaher(location: currentLocation!)
        // perfomr segue
        performSegue(withIdentifier: "second", sender: self)
        return true
        }
}


//GET USER LOCATION AND AUTHOURIZATION
extension MapViewViewController:  CLLocationManagerDelegate {
    
    // LOCATION Auth
    func requestAuthorization(){
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied,.restricted:
            self.showEventsAcessDeniedAlert()
            print("location access denied")
        default:
            locationmanager.requestWhenInUseAuthorization()
            
        }
    }
    
    func showEventsAcessDeniedAlert() {
        let alertController = UIAlertController(title: "Weather Data!",
                                                message: "The location permission was not authorized. Please enable it in Settings to to fetch weather data.",
                                                preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
            
            
            if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(appSettings as URL, options: [:], completionHandler: nil)
            }
        }
        
        
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    
    //DELEGATE MTHOS OG LOCATION MANAGER
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        guard !didFindLocation else{return}
        if let location = locations.first {
            print("Found user's location: \(location)")
            
            // CHECK IF DEFAULT MARKER PRESENT 
            // REMOVE THAT AFTER FINDING USER LOCATION 
            // AND ADD A MARKER ON USER LOCATION
            if let _ = marker{
                marker?.map = nil
                isMarkerOnMap = false
            }
            didFindLocation = true
            self.currentLocation = location
            let camera = GMSCameraPosition.camera(withLatitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!, zoom: 17)
            mapView?.animate(to: camera)
            locationmanager.stopUpdatingLocation()
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("OKJO")
        print("Failed to find user's location: \(error.localizedDescription)")
        self.currentLocation = CLLocation(latitude: 28, longitude: 77)
        let camera = GMSCameraPosition.camera(withLatitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!, zoom: 17)
        mapView?.animate(to: camera)
    }

    
// SEND DATA TO DETAIL VIEW CONTROLLER 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "second"{
            let dest = segue.destination as! ViewController
            dest.vlat = (self.currentLocation?.coordinate.latitude)!
            dest.vlog = (self.currentLocation?.coordinate.longitude)!
        }
    }
}



