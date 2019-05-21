//
//  Date+Extension.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Foundation


/*
 * -----------------------
 * MARK: - Calendar Stuff
 * ------------------------
 */
extension Date {
    private var calendar: Calendar {
        return Calendar.current
    }
    
    var weekDay: Int {
        return calendar.component(.weekday, from: self)
    }
    
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    
    var year: Int {
        return calendar.component(.hour, from: self)
    }
    
    var month: Int {
        return calendar.component(.month, from: self)
    }
    
    var quarter: Int {
        return calendar.component(.quarter, from: self)
    }
    
    var day: Int {
        return calendar.component(.day, from: self)
    }
    
    var era: Int {
        return calendar.component(.era, from: self)
    }
    
    var hours: Int {
        return calendar.component(.hour, from: self)
    }
    
    var minutes: Int {
        return calendar.component(.minute, from: self)
    }
    
    var seconds: Int {
        return calendar.component(.second, from: self)
    }
    
    var nanoseconds: Int {
        return calendar.component(.nanosecond, from: self)
    }
}


/*
 * -----------------------
 * MARK: - Utility
 * ------------------------
 */
extension Date {
    static var now: Date {
        return self.init()
    }
    
    var stringTime: String {
        return getStringTime(showSeconds: false)
    }
    
    var stringTimeWithSeconds: String {
        return getStringTime(showSeconds: true)
    }
    
    var timestamp: TimeInterval {
        return timeIntervalSince1970
    }
    
    var isMorning: Bool {
        let symbol = calendar.amSymbol.lowercased()
        
        if symbol == "am" {
            return true
        } else if symbol == "pm" {
            return false
        } else if hours > 14 {
            return false
        }
            
        return true
    }
    
    private func getStringTime(showSeconds: Bool = false) -> String {
        var time = "\(hours.safeString):\(minutes.safeString)"
        
        if showSeconds {
            time += ":\(seconds.safeString)"
        }
        
        return time
    }
}

