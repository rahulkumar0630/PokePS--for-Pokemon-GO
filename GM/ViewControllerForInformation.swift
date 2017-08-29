//
//  ViewControllerForInformation.swift
//  GM
//
//  Created by Rahul Kumar on 7/27/16.
//  Copyright © 2016 Rahul Kumar. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class ViewControllerForInformation: UIViewController {
    
    @IBOutlet weak var LabelForPokemonName: UILabel!
    var addlike:Int = 0
    let StoringPin = FIRDatabase.database().reference().child("locations")
    
    @IBOutlet weak var OutletBack: UIButton!
    @IBOutlet weak var Outletforuser: UILabel!
    @IBOutlet weak var GetDirections: UIButton!
    @IBOutlet weak var AddLike: UILabel!
    @IBOutlet weak var LabelForDate: UILabel!
    @IBOutlet weak var Dislike: UILabel!
    //let AddNumber = NSUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        

        
        
        
        
        
        
        self.OutletBack.layer.cornerRadius = 4
        self.GetDirections.layer.cornerRadius = 4
       // self.AddPercentage.layer.cornerRadius = 4
        //self.DecreasePercentage.layer.cornerRadius = 4
        
        self.LabelForDate.text = stringfordate2
        self.Outletforuser.text = stringforemail
        
        self.LabelForPokemonName.text = stringforname
       
        //self.LabelForDate.text = stringfordate
        
        
        
//        if self.LabelForPokemonName.text == stringforname{
//            
//            let image: UIImage = UIImage(named: stringforname)!
//            var bgImage = UIImageView(image: image)
//            bgImage = UIImageView(image: image)
//            
//            bgImage.frame = CGRect(x: 110,y: 330,width: 200,height: 300)
//            self.view.addSubview(bgImage)
//        
//            }
        
            
    
        
        //hieght is far most right
        //width is 2nd to last right
        //left most is x
        //second value is y
        

    }
    @IBAction func BackButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "SegueFromInfotoMap", sender: self)
        
        }
    
    @IBAction func AddLike(_ sender: AnyObject) {
        
        
        
        //print(++addlike)
        
//        StoringPin.runTransactionBlock({
//            snapshot in
//            var value1 = snapshot.value as? Int
//
//            NumberOfLikes = Numoflikes
//            
//            Numoflikes = Numoflikes + NumberOfLikes
//            
//            return FIRTransactionResult.successWithValue(snapshot)
//            
//           self.StoringPin.child(UID).updateChildValues(["Likes": Numoflikes])
//            
//        })
 
        
        
        

         StoringPin.observe(.childAdded,with: {
            
        
            snapshot in
            if snapshot.value is NSNull {
                return
            }
            
            let NumofLikes = (snapshot.value! as AnyObject).object(forKey: "Likes") as? Int
            
            NumberOfLikes2 = NumofLikes!
            
            
            //self.StoringPin.child(UID).updateChildValues(["Likes": (++NumberOfLikes2)])
               
            

                
            

        })
        
    }

    
    @IBAction func GetDirectons(_ sender: AnyObject) {
        
        let placemark = MKPlacemark(coordinate: coords, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(stringforname)"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
    }
    
    @IBAction func AddDislike(_ sender: AnyObject) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
