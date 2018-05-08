//
//  Litterature.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 07/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Litterature: NSObject {
    
    let ref: DatabaseReference?
    let periodName: String?
    let genreName: String?
    let textName: String?
    let pagesNS: Int?
    
    init(periodName: String, genreName: String, textName: String, pagesNS: Int) {
        self.ref = nil
        self.periodName = periodName
        self.genreName = genreName
        self.textName = textName
        self.pagesNS = pagesNS
    }
    
    init?(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.periodName = snapshotValue["periodeName"] as? String
        self.genreName = snapshotValue["genreName"] as? String
        self.textName = snapshotValue["textName"] as? String
        self.pagesNS = snapshotValue["pagesNS"] as? Int
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "periodeName": periodName,
            "genreName": genreName,
            "textName": textName,
            "pagesNS": pagesNS
        ]
    }
}
