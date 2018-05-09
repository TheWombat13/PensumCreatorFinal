//
//  LitteratureTableViewController.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 04/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit
import Firebase

class LitteratureTableViewController: UITableViewController {
    
    let ref : DatabaseReference = Database.database().reference(withPath: "Pensums")
    var pensumKey: String?
    var litteratureList: [Litterature] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pensumKey = pensumKey {
            print("Pensum key: \(pensumKey)")
        }
        fetchLitterature()
    }
    

    func fetchLitterature() {
        if let pensumKey = pensumKey {
            let litteratureRef = ref.child(pensumKey).child("litteratureList")
            litteratureRef.observe(.value, with: { snapshot in
                var newLitteratureList: [Litterature] = []
                
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let litterature = Litterature(snapshot: snapshot) {
                        let litteratureKey = snapshot.key
                        print("LitteratureKey: \(litteratureKey)")
                        newLitteratureList.append(litterature)
                    }
                }
                self.litteratureList = newLitteratureList
                self.tableView.reloadData()
                print(snapshot)
            })
        }
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
        return litteratureList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let litterature = litteratureList[indexPath.row]
            litterature.ref?.removeValue()
        }
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "LitteratureTableViewCustomCell", for: indexPath)
        let litterature = litteratureList[indexPath.row]
        cell.textLabel?.text = litterature.periodName!
        cell.detailTextLabel?.text = "\(String(describing: litterature.pagesNS!))"

     return cell
     }
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  (segue.identifier == "toAddLitterature") {
            let litteratureRef = segue.destination as! AddLitteratureViewController
            litteratureRef.pensumKey = pensumKey
        } else if segue.identifier == "toDetailLitterature"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let litterature = litteratureList[indexPath.row]
                let detailViewController = segue.destination as! DetailLitteratureViewController
                detailViewController.litterature = litterature
        }
    }
}
    
    
 
    @IBAction func unwindToLitteratureTable(segue: UIStoryboardSegue){
        let AddLitteratureViewController = segue.source as! AddLitteratureViewController
         if let litterature = AddLitteratureViewController.litterature {
        litteratureList.append(litterature)
        self.tableView.reloadData()
         }
    }
    
}
