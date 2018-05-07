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
    @IBOutlet weak var litteraturePagesTextField: UITextField!
    @IBOutlet weak var TextTextField: UITextView!
    
    var ref: DatabaseReference?
    var litterature: Litterature?

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addLitterature(_ sender: Any) {
        let autoId = ref?.child("Pensums").child("litterature").childByAutoId()
        
        autoId?.child("periodName").setValue(periodTextField.text)
        autoId?.child("genreName").setValue(genreTextField.text)
        autoId?.child("textName").setValue(TextTextField.text)
        autoId?.child("litteraturePages").setValue(litteraturePagesTextField.text)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
