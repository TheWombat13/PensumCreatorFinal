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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "LitteratureTableViewCustomCell", for: indexPath)
        let litterature = litteratureList[indexPath.row]
        
        cell.textLabel?.text = litterature.genreName
        
     // Configure the cell...
     
     return cell
     }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("før")
        if  (segue.identifier == "toAddLitterature") {
            print("efter")
            let litteratureRef = segue.destination as! AddLitteratureViewController
            litteratureRef.pensumKey = pensumKey
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
   // @IBAction func unwindToLitteratureTable(segue: UIStoryboardSegue){
     //   let AddLitteratureViewController = segue.source as! AddLitteratureViewController
        // if let pensum = AddLitteratureViewController.litterature {
        //pensums.append(pensum)
        //self.tableView.reloadData()
        // }
        
    //}
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
    
    
}
