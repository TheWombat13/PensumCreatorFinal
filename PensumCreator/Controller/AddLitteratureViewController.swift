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
    //var pagesNS:

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func countPages(pagesNS: Int) {
        
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
        
        if periodTextField.text == "" || signsTextField.text == "" || linesTextField.text == ""
            || pagesToTextField.text == "" || pagesFromTextField.text == ""{
            let alertController = UIAlertController(title: "Advarsel", message: "Udfyld venligst periode og sideinformationer", preferredStyle: .alert)
            let defaltAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaltAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            let signsTextfieldInt: Int! = Int(signsTextField.text!)
            let linesTextfieldInt: Int! = Int(linesTextField.text!)
            let pagesFromTextfieldInt: Int! = Int(pagesFromTextField.text!)
            let pagesToTextfieldInt: Int! = Int(pagesToTextField.text!)
            let pagesNS = ((signsTextfieldInt * linesTextfieldInt) / 2400) * (pagesToTextfieldInt - pagesFromTextfieldInt + 1)
            
            let autoId = ref?.child("Pensums").child("litterature").childByAutoId()
            autoId?.child("periodName").setValue(periodTextField.text)
            autoId?.child("genreName").setValue(genreTextField.text)
            autoId?.child("textName").setValue(TextTextField.text)
            autoId?.child("pagesNS").setValue(pagesNS)

            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
