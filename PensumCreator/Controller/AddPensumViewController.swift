//
//  AddPensumViewController.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 05/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddPensumViewController: UIViewController {
    
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var teacherTextField: UITextField!
    @IBOutlet weak var pagesTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var pensumKey: String?
    var ref: DatabaseReference?
    var pensum: Pensum?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPensum(_ sender: Any) {
        if courseTextField.text == "" {
            let alertController = UIAlertController(title: "Advarsel", message: "Udfyld venligst Kursusnavn", preferredStyle: .alert)
            let defaltAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaltAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
        //defines a random key to hold the pensum variables
        let autoId = ref?.child("Pensums").childByAutoId()
        
        autoId?.child("courseName").setValue(courseTextField.text)
        autoId?.child("teacherName").setValue(teacherTextField.text)
        autoId?.child("pensumPages").setValue(pagesTextField.text)
        autoId?.child("litteratureList").setValue(0)
      
        presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
        if sender as? UIBarButtonItem == doneButton {
            if !((courseTextField.text?.isEmpty)!) && !(teacherTextField.text?.isEmpty)! && !(pagesTextField.text?.isEmpty)! {
                pensum = Pensum(courseName: courseTextField.text!, teacherName: teacherTextField.text!, pensumPages: pagesTextField.text!)
            }
        }
    }
    
}
