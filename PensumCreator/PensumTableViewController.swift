//
//  PensumTableViewController.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 01/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit
import Firebase


class PensumTableViewController: UITableViewController {
    
    weak var currentUser = Auth.auth().currentUser
    var pensums = [Pensum]()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("jeg loader")
       
        fetchPensums()
        
    }
 
 
    func fetchPensums() {
    
        Database.database().reference().child("Pensums").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let pensum = Pensum()
                pensum.setValuesForKeys(dictionary)
                print(pensum.courseName as Any, pensum.teacherName as Any, pensum.pensumPages as Any)
 
            }
 
            
            
            print("pensum found")
            print(snapshot)
        })
        
    
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
    @IBAction func signOut(){
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "PensumTableView", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PensumTableViewCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "hello"//pensums[indexPath.row].courseName

        return cell
    }
    

    
    

}
