//
//  DetailLitteratureViewController.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 07/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit

class DetailLitteratureViewController: UIViewController {
    
    var litterature: Litterature? {
        didSet {
            configureView()
        }
    }
    
    
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var pagesNSLabel: UILabel!
    @IBOutlet weak var tekstLabel: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        print("test3")
        if let litterature = self.litterature {
            if let periodLabel = self.periodLabel,
            let genreLabel = self.genreLabel,
            let pagesNSLabel = self.pagesNSLabel,
                let tekstLabel = self.tekstLabel {
                periodLabel.text = litterature.periodName
                genreLabel.text = litterature.genreName
                pagesNSLabel.text = "\(String(describing: litterature.pagesNS!))"
                tekstLabel.text = litterature.textName
                print("test2")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
       
    

}
