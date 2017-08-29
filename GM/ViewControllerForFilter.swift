////
////  ViewControllerforFilter.swift
////  GM
////
////  Created by Rahul Kumar on 7/26/16.
////  Copyright © 2016 Rahul Kumar. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//class ViewControllerforFilter: UIViewController, CLLocationManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
//    let locationManager = CLLocationManager()
//    var currentLoc:CLLocationCoordinate2D?
//    var centerMap = true
//    
//    
//    @IBOutlet weak var MapView: MKMapView!
//    
//    @IBOutlet weak var pickerView: UIPickerView!
//    
//    @IBOutlet weak var Filter: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.pickerView.dataSource = self;
//        self.pickerView.delegate = self;
//        self.Filter.layer.cornerRadius = 4
//        
//        self.locationManager.requestAlwaysAuthorization()
//        self.locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
//        
//        Intforfilter = 0
//        
//    }
//    
//    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return FilterDataSource.count;
//    }
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return FilterDataSource[row]
//    }
//    
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
//    {
//        Intforfilter = row
//        /*
//         if(row == 0)
//         {
//         self.view.backgroundColor = UIColor.whiteColor();
//         }
//         else if(row == 1)
//         {
//         self.view.backgroundColor = UIColor.redColor();
//         }
//         else if(row == 2)
//         {
//         self.view.backgroundColor =  UIColor.greenColor();
//         }
//         else
//         {
//         self.view.backgroundColor = UIColor.blueColor();
//         }
//         */
//    }
//    
//    let regionRadius: CLLocationDistance = 1000
//    
//    
//    func centerMapOnLocation(location: CLLocation) {
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
//                                                                  regionRadius * 2.0, regionRadius * 2.0)
//        MapView.setRegion(coordinateRegion, animated: true)
//    }
//    
//    @IBAction func ButtonForFilteringPokemon(sender: AnyObject) {
//        FilterBoolean = true
//        
//        
//        print(FilterBoolean)
//        
//               self.performSegueWithIdentifier("Seguebacktoview", sender: self)
//        
//    }
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        
//        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
//            MapView.showsUserLocation = true
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
//        
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        
//        currentLoc = locValue
//        
//        if centerMap {
//            centerMap = false
//            centerMapOnLocation(CLLocation(latitude: currentLoc!.latitude, longitude: currentLoc!.longitude))
//        }
//        
//    }
//    @IBAction func FindLocation(sender: AnyObject) {
//        centerMapOnLocation(CLLocation(latitude: currentLoc!.latitude, longitude: currentLoc!.longitude))
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//    
//    
//}
//
