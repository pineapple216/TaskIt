//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Koen Hendriks on 11/11/14.
//  Copyright (c) 2014 Koen Hendriks. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    var mainVC:ViewController!
    
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
        var task = TaskModel(task: self.taskTextField.text, subTask: self.subTaskTextField.text, date: self.dueDatePicker.date)
        mainVC.taskArray.append(task)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
