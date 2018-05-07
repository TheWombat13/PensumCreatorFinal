//
//  Pensum.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 03/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Pensum: NSObject {
    
    
    let ref: DatabaseReference?
    let courseName: String?
    let teacherName: String?
    let pensumPages: String?
    
    //Constructor for instantiating a new object
    init(courseName: String, teacherName: String, pensumPages: String) {
        self.ref = nil
        self.courseName = courseName
        self.teacherName = teacherName
        self.pensumPages = pensumPages
    }
    
    //Constructor for instantiating an object from FireBase
    init?(snapshot: DataSnapshot) {
            let snapshotValue = snapshot.value as! [String: AnyObject]
            self.courseName = snapshotValue["courseName"] as? String
            self.teacherName = snapshotValue["teacherName"] as? String
            self.pensumPages = snapshotValue["pensumPages"] as? String
            self.ref = snapshot.ref
 
    }

    
    func toAnyObject() -> Any {
        return [
            "courseName": courseName,
            "teacherName": teacherName,
            "pensumPages": pensumPages,

        ]

}
}

