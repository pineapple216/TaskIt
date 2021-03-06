//
//  ViewController.swift
//  TaskIt
//
//  Created by Koen Hendriks on 09/11/14.
//  Copyright (c) 2014 Koen Hendriks. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, TaskDetailViewControllerDelegate, AddTaskViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

		fetchedResultsController = getFetchedResultsController()
		fetchedResultsController.delegate = self
		fetchedResultsController.performFetch(nil)
    }
    
    // Reload the data in the tableView when this viewController becomes the main view controller
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
		
		
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare for segue is called just before the new VC is presented on the screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Check that we are going to the taskDetail VC
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            // Get the indexPath for the currently selected row in the tableView
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            
            // Set the detailTaskModel in the destinationVC to contain the currently selected task
            detailVC.detailTaskModel = thisTask
			detailVC.delegate = self
        }
        
        else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
			addTaskVC.delegate = self
        }
        
    }
    
    // MARK: IBAction
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
    
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if fetchedResultsController.sections?.count == 1{
			let fetchedObjects = fetchedResultsController.fetchedObjects!
			let testTask:TaskModel = fetchedObjects[0] as TaskModel
			
			if testTask.completed == true{
				return "Completed"
			}
			else{
				return "To do"
			}
		}
		else{
			if section == 0 {
				return "To do"
			}
			else {
				return "Completed"
			}
		}
    }
	
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
		
		if thisTask.completed == true{
			thisTask.completed = false
		}
		else{
			thisTask.completed = true
		}
		
		(UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
	
	// MARK: - NSFetchedResultsControllerDelegate
	
	// When the NSFetchedResultsController detects changes to our CoreData stack, reload the tableView
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		tableView.reloadData()
	}
	
	// MARK: - Helper Methods
	func taskFetchRequest() -> NSFetchRequest {
		let fetchRequest = NSFetchRequest(entityName: "TaskModel")
		
		// Create a sortDescriptor to sort our results on date
		let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
		let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
		fetchRequest.sortDescriptors = [completedDescriptor,sortDescriptor]
		
		return fetchRequest
	}
	
	func getFetchedResultsController() -> NSFetchedResultsController {
		fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
		
		return fetchedResultsController
	}
	
	// MARK: TaskDetailViewControllerDelegate
	
	func taskDetailEdited() {
		showAlert()
	}
	
	// MARK: AddTaskViewControllerDelegate
	
	func addTaskCanceled(message: String) {
		showAlert(message: message)
	}
	
	func addTask(message: String) {
		showAlert(message: message)
	}
	
	func showAlert(message:String = "Congratulations"){
		var alert = UIAlertController(title: "Change Made!", message: message, preferredStyle: UIAlertControllerStyle.Alert)
		alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
}













