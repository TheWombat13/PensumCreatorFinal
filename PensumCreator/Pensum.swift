//
//  Pensum.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 03/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit
import Firebase

class Pensum: NSObject {
    
   // var courseName: String?
   // var teacherName: String?
   // var pensumPages: Int?
    
    let courseName: String
    let teacherName: String
    let pensumPages: Int
    
    
    init(courseName: String, teacherName: String, pensumPages: Int) {
        self.courseName = courseName
        self.teacherName = teacherName
        self.pensumPages = pensumPages
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        courseName = snapshotValue["courseName"] as! String
        teacherName = snapshotValue["teacherName"] as! String
        pensumPages = snapshotValue["pensumPages"] as! Int
    }
    
    func toAnyObject() -> Any {
        return [
            "courseName": courseName,
            "teacherName": teacherName,
            "pensumPages": pensumPages
        ]

}
}
