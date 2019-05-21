//
//  NewReminderVC.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Cocoa


protocol NewReminderVCDelegate {
    func onSubmit(_ sender: NSButton, reminder: Reminder) -> Void
}

class NewReminderVC: NSViewController {
    var delegate: NewReminderVCDelegate!
    
    @IBOutlet weak var taskTitle: NSTextField!
    @IBOutlet weak var taskDate: NSDatePicker!
    @IBOutlet weak var taskDescr: NSTextView!

    @IBAction func onSubmit(_ sender: NSButton) {
        let reminder = Reminder(
            taskTitle.stringValue,
            description: taskDescr.string,
            fireOnDate: taskDate.dateValue,
            tag: nil
        )
        
        delegate.onSubmit(sender, reminder: reminder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTitle.stringValue = ""
        taskDescr.string = ""
        
        taskDate.calendar = Calendar.current
        taskDate.dateValue = Date.now
    }
}
