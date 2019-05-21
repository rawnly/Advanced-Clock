//
//  Reminder.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Foundation

protocol ReminderDelegate {
    func onReminderFired(_ reminder: Reminder) -> Void
}

class Reminder {
    private typealias Notification = NSUserNotification
    
    var timer: Timer!
    var title: String!
    var descr: String?
    
    var tag: Int?
    var fireDate: Date
    var delegate: ReminderDelegate?
    
    
    init(_ title: String, description descr: String? = nil, fireOnDate date: Date, tag: Int? = nil) {
        self.title = title
        fireDate = date
        self.tag = tag
        self.descr = descr
        
        print("Timer will fire at: \(fireDate.timeIntervalSinceNow)")
        print(fireDate)
        
        self.timer = Timer.scheduledTimer(
            withTimeInterval: fireDate.timeIntervalSinceNow,
            repeats: false,
            block: { (t) in
                t.invalidate()
                
                let notification = NSUserNotification()
                
                notification.title = self.title
                notification.informativeText = self.descr
                notification.subtitle = "Your timer has fired"
                
                NSUserNotificationCenter.default.deliver(notification)
                
                if let d = self.delegate {
                    d.onReminderFired(self)
                }
            }
        )

    }
}
