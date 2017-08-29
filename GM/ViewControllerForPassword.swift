//
//  ViewControllerForPassword.swift
//  
//
//  Created by Rahul Kumar on 7/25/16.
//
//

import UIKit
import Firebase
import FirebaseAuth
class ViewControllerForPassword: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var OutletforSending: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        OutletforSending.layer.cornerRadius = 4
        DoneButton.layer.cornerRadius = 4
        EmailField.delegate = self


        
    }

    @IBAction func SendPasswordtoEmail(_ sender: AnyObject) {
        if self.EmailField.text == ""        {
            let alertController = UIAlertController(title: "Oops", message: "Please enter the email of your account.", preferredStyle: .alert)
            
            let DefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(DefaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            FIRAuth.auth()?.sendPasswordReset(withEmail: self.EmailField.text!, completion: { (error) in
                
                if error == nil{
                    let alertController = UIAlertController(title: "Email Sent", message: "A password reset email was sent to the email above", preferredStyle: .alert)
                    
                    let DefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(DefaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    

                }
                else{
                    let alertController = UIAlertController(title: "Sorry", message: "There is not an account for the email entered.", preferredStyle: .alert)
                    
                    let DefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(DefaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            })
                    }
        
        
    }
    
    @IBAction func DoneTap(_ sender: AnyObject) {
       self.performSegue(withIdentifier: "SegueBack", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         if textField == EmailField {
            self.view.endEditing(true)
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
