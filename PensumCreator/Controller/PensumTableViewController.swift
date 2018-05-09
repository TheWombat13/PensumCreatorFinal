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
    var pensumKeys: [String] = []
    let ref = Database.database().reference(withPath: "Pensums")

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPensums()
        
    }
    
    
    func fetchPensums() {
        ref.observe(.value, with: { snapshot in
        var newPensums: [Pensum] = []
        var newPensumKeys: [String] = []
        
        for child in snapshot.children {
            if let snapshot = child as? DataSnapshot,
                let pensum = Pensum(snapshot: snapshot) {
                let pensumKey = snapshot.key
                print("PensumKey: \(pensumKey)")
                newPensumKeys.append(pensumKey)
                newPensums.append(pensum)
            }
        }
        self.pensums = newPensums
        self.pensumKeys = newPensumKeys
        self.tableView.reloadData()
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
        
        return pensums.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  (segue.identifier == "toLitteratureList") {
            let litteratureTVC = segue.destination as! LitteratureTableViewController
            if let selectionIndex = tableView.indexPathForSelectedRow {
                litteratureTVC.pensumKey = pensumKeys[selectionIndex.row]
            }
        }
    }
    

    
    
    @IBAction func unwindToPensumTable(segue: UIStoryboardSegue){
        let AddPensumViewController = segue.source as! AddPensumViewController
        if let pensum = AddPensumViewController.pensum {
            pensums.append(pensum)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("section: \(indexPath.section)")
        //print("row: \(indexPath.row)")
        
    }
    
    //function for deletion of tableview elements
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Warning for deletion of a pensum
            let alertController = UIAlertController(title: "Advarsen", message: "Du er ved at slette et pensum med alle underliggende værker", preferredStyle: .alert)
 
            let cancelAction = UIAlertAction(title: "Afbryd", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
            let deleteAction = UIAlertAction(title: "Slet", style: .destructive, handler: { (action) in
                let pensum = self.pensums[indexPath.row]
                pensum.ref?.removeValue()
            })
            alertController.addAction(deleteAction)
        }
    }
    
//
    //Custom cell loader
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PensumTableViewCustomCell", for: indexPath)

        if let customCell = cell as? PensumTableViewCustomCell {
            let pensum = pensums[indexPath.row]
            customCell.courseLabel.text = pensum.courseName
            customCell.teacherLabel.text = pensum.teacherName
            customCell.pagesLabel.text = pensum.pensumPages
        }
        return cell
    }
    
//    @IBAction func signOut(){
//        if Auth.auth().currentUser != nil {
//            do {
//                try Auth.auth().signOut()
//                let vc = UIStoryboard(name: "PensumTableViewController", bundle: nil).instantiateViewController(withIdentifier: "Login")
//                present(vc, animated: true, completion: nil)
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
    

}
