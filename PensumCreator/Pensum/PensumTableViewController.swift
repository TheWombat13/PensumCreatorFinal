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
    
    //let ref = Database.database().reference().child("Pensums")
    weak var currentUser = Auth.auth().currentUser
    //var pensums = [Pensum]()
    var pensums: [Pensum] = []
    let ref = Database.database().reference(withPath: "Pensums")

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPensums()
        
    }
    
    
    func fetchPensums() {
        ref.observe(.value, with: { snapshot in
        var newPensums: [Pensum] = []
        
        for child in snapshot.children {
            if let snapshot = child as? DataSnapshot,
                let pensum = Pensum(snapshot: snapshot) {
                newPensums.append(pensum)
            }
        }
        self.pensums = newPensums
        self.tableView.reloadData()
            print(snapshot)
        })
    }
 
    /*
    func fetchPensums() {
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let pensum = Pensum()
                //pensum.setValuesForKeys(dictionary)
                pensum.courseName = dictionary["courseName"] as? String
                pensum.teacherName = dictionary["teacherName"] as? String
                pensum.teacherName = dictionary["pensumPages"] as? String
                
                self.pensums.append(pensum)
                self.tableView.reloadData()
                
                print(pensum.courseName, pensum.teacherName, pensum.pensumPages)
            }
            print("pensum found")
            print(snapshot)
        })
    }
*/
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
        return pensums.count
    }
    
    @IBAction func unwindToPensumTable(segue: UIStoryboardSegue){
        let AddPensumViewController = segue.source as! AddPensumViewController
        if let pensum = AddPensumViewController.pensum {
            pensums.append(pensum)
            self.tableView.reloadData()
        }

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

    //TODO create custom cell 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PensumTableViewCell", for: indexPath)

        let pensum = pensums[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text =  pensum.courseName
        cell.detailTextLabel?.text = pensum.teacherName

        return cell
    }
    

}
