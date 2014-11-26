//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Koen Hendriks on 11/11/14.
//  Copyright (c) 2014 Koen Hendriks. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions - Bar buttons
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTaskButtonTapped(sender: UIButton) {
		let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
		let managedObjectContext = appDelegate.managedObjectContext
		let entityDescription = NSEntityDescription.entityForName("TaskModel",
			inManagedObjectContext: managedObjectContext!)
		
		let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
		
		task.task = taskTextField.text
		task.subtask = subTaskTextField.text
		task.date = dueDatePicker.date
		task.completed = false
		
		// Save changes to our entity
		appDelegate.saveContext()
		
		// Check is the data is saved correctly by requesting the entity from CoreData
		var request = NSFetchRequest(entityName: "TaskModel")
		var error:NSError? = nil
		
		var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
		
		for res in results {
			println(res)
		}
		
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}











