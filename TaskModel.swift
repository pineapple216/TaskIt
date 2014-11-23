//
//  TaskModel.swift
//  TaskIt
//
//  Created by Koen Hendriks on 23/11/14.
//  Copyright (c) 2014 Koen Hendriks. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
