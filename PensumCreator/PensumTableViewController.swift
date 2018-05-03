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
    var ref: DatabaseReference!
    var refHandle: UInt!
    weak var currentUser = Auth.auth().currentUser
    var pensums = [Pensum]()
    //let tasksReference = Database.database().reference()
    
  //  static let kPensumListPath = "LitteraturList"
  //  static let kPensumListViewControllerSegueIdentifier = "LitteraturTableViewController"
    
  //  let PensumReference = Database.database().reference(withPath: kPensumListPath)
  //  var Pensums = [Pensum]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("jeg loader")
        ref = Database.database().reference()
        fetchPensums()
        
      //  ref.observe(.value) { (snapshot) in
      //      var items: [Pensum] = []
            
      //      for item in snapshot.children {
      //          let pensum = Pensum(snapshot: item as! DataSnapshot)
      //          items.append(pensum)
      //      }
      //      self.pensums = items
      //      self.tableView.reloadData()
 
 
 }
 
 
    func fetchPensums() {
        refHandle = ref.child("Pensums").observe(.childAdded, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(dictionary )
                
                let pensum = Pensum()
                pensum.setValuesForKeys(dictionary)
                self.pensums.append(pensum)
                
                self.tableView.reloadData()
                DispatchQueue.main.async {
                }
            }
        })
    }
    


/*
    func fillPensums() {
        ref = Database.database().reference()
        ref.observe(.value) { (snapshot) in
            var items: [Pensum] = []
            
            for item in snapshot.children {
                let pensum = Pensum(snapshot: item as! DataSnapshot)
                items.append(pensum)
            }
            self.pensums = items
            self.tableView.reloadData()
        }
        
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pensums.count
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
        cell.textLabel?.text = pensums[indexPath.row].courseName

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
