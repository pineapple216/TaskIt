//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Koen Hendriks on 11/11/14.
//  Copyright (c) 2014 Koen Hendriks. All rights reserved.
//

import UIKit

@objc protocol TaskDetailViewControllerDelegate {
	optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
        
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
	
	var delegate:TaskDetailViewControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions - Bar button items
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
		
		let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
		
		detailTaskModel.task = taskTextField.text
		detailTaskModel.subtask = subtaskTextField.text
		detailTaskModel.date = dueDatePicker.date
		detailTaskModel.completed = detailTaskModel.completed
		
		appDelegate.saveContext()
		
        self.navigationController?.popViewControllerAnimated(true)
		delegate?.taskDetailEdited!()
    }
}


















