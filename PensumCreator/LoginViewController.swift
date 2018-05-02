//
//  LoginViewController.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 01/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//
// https://www.appcoda.com/firebase-login-signup/

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    

    //creates referende to read Strings from textfields in main.storyboard
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func login() {
          print("login")
        if emailTextField.text == "" || passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "indtast email og kodeord", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                if error == nil {
                    print("du er nu logged ind")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PensumTableView")
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Fejl", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // TODO translate Errormessages to danish
    @IBAction func register(_ sender: AnyObject){
        print("register")
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Indtast email og kodeord", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil{
                    print("Du har nu oprettet en bruger")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PensumTableView")
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
   

}
