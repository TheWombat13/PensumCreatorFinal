//
//  Pensum.swift
//  PensumCreator
//
//  Created by Jonathan Larsen on 03/05/2018.
//  Copyright © 2018 Jonathan Larsen. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class Pensum: NSObject {
    
   // var courseName: String?
   // var teacherName: String?
   // var pensumPages: Int?
    
    let courseName: String
    let teacherName: String
    let pensumPages: String
    var completed: Bool
    
    
    init(courseName: String, teacherName: String, pensumPages: String, completed: Bool) {
        self.courseName = courseName
        self.teacherName = teacherName
        self.pensumPages = pensumPages
        self.completed = completed
    }
    
    init?(snapshot: DataSnapshot) {
        guard
        let snapshotValue = snapshot.value as? [String: AnyObject],
            let courseName = snapshotValue["courseName"] as? String,
            let teacherName = snapshotValue["teacherName"] as? String,
            let pensumPages = snapshotValue["pensumPages"] as? String,
            let completed = snapshotValue["completed"] as? Bool else {
            return nil
    }
        self.courseName = courseName
        self.teacherName = teacherName
        self.pensumPages = pensumPages
        self.completed = completed
    }
    
    func toAnyObject() -> Any {
        return [
            "courseName": courseName,
            "teacherName": teacherName,
            "pensumPages": pensumPages,
            "completed": completed
        ]

}
}

