//
//  ViewController.swift
//  GM
//
//  Created by Rahul Kumar on 7/20/16.
//  Copyright © 2016 Rahul Kumar. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var AppleMap: MKMapView!
    
    @IBOutlet weak var LogoutOutlet: UIButton!
    
    @IBOutlet weak var OutletforAddPokemon: UIButton!
    
    @IBOutlet weak var FindLocationOutlet: UIButton!
    
    @IBOutlet weak var FilterOutlet: UIButton!
    
    let locationManager = CLLocationManager()
    let calendar: Calendar! = Calendar(identifier: Calendar.Identifier.gregorian)
    
    var increment:Int = 0
    var currentLoc:CLLocationCoordinate2D?
    var centerMap = true
    let StoringPin = FIRDatabase.database().reference().child("locations")
    
    var Date = Foundation.Date()
    var viewloaded:Int = 1
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppleMap.delegate = self
        
        
        StoringPin.observe(.value, with: {
            snapshot in
            if snapshot.value is NSNull {
                return
            }
            let val = snapshot.value as! [String : [String : AnyObject]]
            
            
            for key in val.keys {
                //print(++self.increment)
                let latitudedata = val[key]!["latitude"] as! Double
                let longitudedata = val[key]!["longitude"] as! Double
                let namedata = val[key]!["name"] as! String
                let Username = val[key]!["Username"]
                    as! String
                    
                let DATE = val[key]!["Date"]
                    as! String
                

                let coord = CLLocationCoordinate2D(latitude: latitudedata, longitude: longitudedata)
                
                let artwork = Capital(title: "\(namedata)", coordinate: coord, username: Username, UIDSTring: UID, date: DATE)
                
                    artwork.subtitle = DATE
                

                Arrayforpins.append(artwork)

                self.AppleMap.addAnnotation(Arrayforpins[Arrayforpins.count - 1])
                

                for Capital in Arrayforpins {
                    
                  self.AppleMap.addAnnotation(Capital)
                    
                    
                }
                

            }
            

        })
        
        //print(++viewloaded)
        
        print(LogoutOutlet)
        LogoutOutlet.layer.cornerRadius = 4
    
        FindLocationOutlet.layer.cornerRadius = 4
        OutletforAddPokemon.layer.cornerRadius = 4
        //FilterOutlet.layer.cornerRadius = 4
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
        
        
        let annotationView = MKAnnotationView()
        let detailButton: UIButton = UIButton.init(type: .detailDisclosure) as UIButton
        annotationView.rightCalloutAccessoryView = detailButton

        
        
    }
    let regionRadius: CLLocationDistance = 1000
    
    
    
    func centerMapOnLocation(_ location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        AppleMap.setRegion(coordinateRegion, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            AppleMap.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        //print("update")
        
        currentLoc = locValue
        
        if centerMap {
            centerMap = false
            centerMapOnLocation(CLLocation(latitude: currentLoc!.latitude, longitude: currentLoc!.longitude))
        }
        
    }
    
    
    @IBAction func SendtoSelector(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "SeguetoSelector", sender: self)
        
    }
    
    
    @IBAction func FilterFunc(_ sender: AnyObject) {
        //self.performSegueWithIdentifier("SeguetoFilter", sender: self)
    }
    
    
    @IBAction func FindLocation(_ sender: AnyObject) {
        centerMapOnLocation(CLLocation(latitude: currentLoc!.latitude, longitude: currentLoc!.longitude))
        
       
    }
    
    @IBAction func Logout(_ sender: AnyObject) {
        LO = true
        self.performSegue(withIdentifier: "BacktoLoginScreen", sender: self)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager
        
        if IndexBoolean == true{
            //let annotationView = MKPinAnnotationView()
            print("Hi")
            
            let artwork = Capital(title: "\(pickerDataSource[chosenindex])", coordinate: CLLocationCoordinate2D(latitude: currentLoc!.latitude, longitude: currentLoc!.longitude), username: stringforemail, UIDSTring: UID, date: stringfordate2)
            
            //print(now)
            print(chosenindex)
            artwork.title = "\(pickerDataSource[chosenindex])"
            AppleMap.addAnnotation(artwork)
            //annotationView.pinColor = artwork.Green

                Arrayforpins.append(artwork)
                print(stringforemail)

            
       AppleMap.addAnnotation(Arrayforpins[Arrayforpins.count - 1])
            
            for Capital in Arrayforpins{
            AppleMap.addAnnotation(Capital)
                
            }
            IndexBoolean = false
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            formatter.timeZone = TimeZone(abbreviation: "Central Time")
            let utcTimeZoneSTR = formatter.string(from: Date)
            
            stringfordate = "\(utcTimeZoneSTR)"
            
            let uid = UUID().uuidString
            UID = uid
            StoringPin.child(uid).setValue(["name" : pickerDataSource[chosenindex],
                "latitude" : currentLoc!.latitude,
                "longitude" : currentLoc!.longitude,"Array Position" : chosenindex,"Username": stringforemail, "Likes": NumberOfLikes2, "Dislikes":
                NumberOfDislike, "UID": UID, "Date": stringfordate])
            

        }

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "Capital"
        //print(++increment)
        
        if annotation.isKind(of: Capital.self) {
            
           // print("CAPITAL")
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                annotationView.annotation = annotation
                return annotationView
            
            } else {
            
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
               //annotationView.pinColor = MKPinAnnotationColor.Green
                let btn = UIButton(type: .detailDisclosure)//                btn.addTarget(self, action: #selector(pressed), forControlEvents: .TouchUpInside)
                annotationView.rightCalloutAccessoryView = btn
                return annotationView
                
            }
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let capital = view.annotation as! Capital
        let placeName = capital.title
        let UserName = capital.username
        
        stringforname = view.annotation!.title!!
        coords = view.annotation!.coordinate
        stringforemail = capital.username
        stringfordate2 = capital.date
        
        
        UID = capital.UIDSTring
        
        print(stringforname)
        print(UID)
       // print(now)
        
        self.performSegue(withIdentifier: "SegueToInfo", sender: self)
        
        
        
    }
    


 
    
}

