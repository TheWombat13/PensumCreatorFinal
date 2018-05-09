//
//  AddLitteratureViewController.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 07/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddLitteratureViewController: UIViewController {
    
    @IBOutlet weak var periodTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var TextTextField: UITextView!
    @IBOutlet weak var signsTextField: UITextField!
    @IBOutlet weak var linesTextField: UITextField!
    @IBOutlet weak var pagesFromTextField: UITextField!
    @IBOutlet weak var pagesToTextField: UITextField!
    @IBOutlet weak var pagesNSLabel: UILabel!
   
    var pagesNS: Int?
    var ref: DatabaseReference?
    var litterature: Litterature?
    var pensumKey: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hej")
        if let pensumKey = pensumKey {
            print("Pensum key: \(pensumKey)")
        }
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func countPages(_ sender: AnyObject) {
        
        if signsTextField.text == "" || linesTextField.text == ""
            || pagesToTextField.text == "" || pagesFromTextField.text == "" {
            let alertController = UIAlertController(title: "Advarsel", message: "udfyld alle felter", preferredStyle: .alert)
            let defaltAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaltAction)
            
            self.present(alertController, animated: true, completion: nil) } else {
           
            let signsTextfieldInt: Int! = Int(signsTextField.text!)
            let linesTextfieldInt: Int! = Int(linesTextField.text!)
            let pagesFromTextfieldInt: Int! = Int(pagesFromTextField.text!)
            let pagesToTextfieldInt: Int! = Int(pagesToTextField.text!)
            
            let pagesNS = ((signsTextfieldInt * linesTextfieldInt) / 2400) * (pagesToTextfieldInt - pagesFromTextfieldInt + 1)
            
            let pagesNSString: String = String(pagesNS)
            pagesNSLabel.text = pagesNSString
        }
        
    }
    
    @IBAction func addLitterature(_ sender: AnyObject) {
        
        //Alerts to check for correct inputs
        if periodTextField.text == "" || signsTextField.text == "" || linesTextField.text == ""
            || pagesToTextField.text == "" || pagesFromTextField.text == ""{
            let alertController = UIAlertController(title: "Advarsel", message: "Udfyld venligst periode og sideinformationer", preferredStyle: .alert)
            let defaltAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaltAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            //Transforms the textFileds to integers
            let signsTextfieldInt: Int! = Int(signsTextField.text!)
            let linesTextfieldInt: Int! = Int(linesTextField.text!)
            let pagesFromTextfieldInt: Int! = Int(pagesFromTextField.text!)
            let pagesToTextfieldInt: Int! = Int(pagesToTextField.text!)
            let pagesNS = ((signsTextfieldInt * linesTextfieldInt) / 2400) * (pagesToTextfieldInt - pagesFromTextfieldInt + 1)
            
            //Saves the data on the Firebase by the defined paths
            if let pensumKey = pensumKey {
            let autoId = ref?.child("Pensums").child(pensumKey).child("litteratureList").childByAutoId()
            autoId?.child("periodName").setValue(periodTextField.text)
            autoId?.child("genreName").setValue(genreTextField.text)
            autoId?.child("textName").setValue(TextTextField.text)
            autoId?.child("pagesNS").setValue(pagesNS)
            }
            //Defines when the unwind segue should run so the data will be stored in the database
            //before unwinding
            self.performSegue(withIdentifier: "unwindToLitteratureTable", sender: self)
            
        }
    }
    
}
