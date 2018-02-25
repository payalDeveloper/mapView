//
//  ViewController.swift
//  MapViewDay5
//
//  Created by Payal Nigade on 15/02/18.
//  Copyright © 2018 Payal Nigade. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSettingsForLocationManager()
        self.initialSettingsForMapView()
    }
    
    func initialSettingsForMapView(){
        
        mapView.mapType = .standard
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.showsUserLocation =  true
        
        
        mapView.showsScale = true
        mapView.isZoomEnabled = true
    }
    
    func initialSettingsForLocationManager(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickFindMyLocation(_ sender: Any) {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations.first
             
        let center = CLLocationCoordinate2D.init(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion.init(center: center, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2D.init(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
        
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if status == .denied{
            
        }
    }
    
}

