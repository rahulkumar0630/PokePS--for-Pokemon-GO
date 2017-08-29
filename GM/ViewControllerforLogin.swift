//
//  ViewControllerforLogin.swift
//  GM
//
//  Created by Rahul Kumar on 7/20/16.
//  Copyright © 2016 Rahul Kumar. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import FirebaseAuth
import MessageUI


class ViewControllerforLogin: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameLogin: UILabel!
    @IBOutlet weak var ViewforLoading: UIView!
    @IBOutlet weak var LoadingAnimation: UIActivityIndicatorView!
    @IBOutlet weak var EmailField: UITextField!
    let UserisLogged = UserDefaults()
    
    //@IBOutlet weak var LoadingScreen: UIActivityIndicatorView!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var OutletforLogin: UIButton!
    
    
    @IBOutlet weak var CreateUserOutlet: UIButton!
    
    @IBOutlet weak var ForgotPasswordOutlet: UIButton!
    
    @IBOutlet weak var logout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OutletforLogin.layer.cornerRadius = 4
        CreateUserOutlet.layer.cornerRadius = 4
        ForgotPasswordOutlet.layer.cornerRadius = 4
        
        
        self.LoadingAnimation.isHidden = true
        self.ViewforLoading.isHidden = true
        
        EmailField.delegate = self
        passwordField.delegate = self
        
        if let user = FIRAuth.auth()?.currentUser {
            self.logout.alpha = 1.0
            self.usernameLogin.text = user.email
            stringforemail = user.email!
            print(stringforemail)
            
        }
        else {
            self.logout.alpha = 0.0
            self.usernameLogin.text = "Welcome"
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.view.backgroundColor = UIColor.blueColor()

        if LO == true{
            self.UserisLogged.set(false, forKey: "Logged in")
            try! FIRAuth.auth()?.signOut()
            
            self.usernameLogin.text = "Welcome"
            self.logout.alpha = 0.0
            self.EmailField.text = ""
            self.passwordField.text = ""
        }
        
        if self.UserisLogged.bool(forKey: "Logged in"){
            
            self.ViewforLoading.isHidden = true
            self.LoadingAnimation.isHidden = true
            
            self.LoadingAnimation.startAnimating()
            self.performSegue(withIdentifier: "SegueToMapsView", sender: self)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func CeateUser(_ sender: AnyObject) {
        

        if self.EmailField.text == "" || self.passwordField.text == ""
        {
            let alertController = UIAlertController(title: "Oops", message: "Please enter an email or password", preferredStyle: .alert)
            
            let DefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(DefaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            FIRAuth.auth()?.createUser(withEmail: self.EmailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                
                
                if error == nil{
                    stringforemail = self.EmailField.text!
                    print(stringforemail)
                    self.performSegue(withIdentifier: "SegueToMapsView", sender: self)
                    self.logout.alpha = 1.0
                    self.usernameLogin.text = user!.email
                    self.EmailField.text = ""
                    self.passwordField.text = ""
                    
                }
                else
                {
                    
                    let alertController = UIAlertController(title: "Oops", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let DefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(DefaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
            
            
        }
    }
    
    @IBAction func ForgotPassword(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "SeguetoForgotPassword", sender: self)
    }
    
        @IBAction func LoginButton(_ sender: AnyObject) {
        
    
    
        if self.EmailField.text == "" || self.passwordField.text == ""
        {
            let alertController = UIAlertController(title: "Oops", message: "Please enter an email or password", preferredStyle: .alert)
            
            let DefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(DefaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            FIRAuth.auth()?.signIn(withEmail: self.EmailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                
                
                
                
                
                if error == nil{
                stringforemail = self.EmailField.text!
                    print(stringforemail)

                    self.ViewforLoading.isHidden = false
                    self.LoadingAnimation.isHidden = false
                    
                    self.LoadingAnimation.startAnimating()
                    self.performSegue(withIdentifier: "SegueToMapsView", sender: self)
                    
                    
                    self.UserisLogged.set(true, forKey: "Logged in")
                    self.logout.alpha = 1.0
                    self.usernameLogin.text = user!.email
                    self.EmailField.text = ""
                    self.passwordField.text = ""
                    
                    //self.performSegueWithIdentifier("SegueToMapsView", sender: self)
                    
                }
                else
                {
                    
                    let alertController = UIAlertController(title: "Oops", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let DefaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(DefaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                
            })
        }
    }
    
    
    
    @IBAction func LogoutButton(_ sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        
        self.usernameLogin.text = ""
        self.logout.alpha = 0.0
        self.EmailField.text = ""
        self.passwordField.text = ""
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == EmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            self.view.endEditing(true)
        }
        return true
    }
 
}












