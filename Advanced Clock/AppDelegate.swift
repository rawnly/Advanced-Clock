//
//  AppDelegate.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Cocoa

let REMINDERS_WINDOW_CONTROLLER: NSWindowController = NSWindowController(window: nil)

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var timer: Timer? = nil
    var reminders: [Reminder] = [] {
        didSet {
            if let menu = statusBarItem.menu, let item = menu.item(withTag: 5) {
                item.submenu = self.getRemindersMenu()
                item.isEnabled = reminders.count > 0
            }
        }
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        if Preferences.firstRunGone == false {
            // This will be executed on first run
            Preferences.firstRunGone = true
            
            // Set preferences to their defaults
            Preferences.restore()
        }
        
        
        DockIcon.standard.setVisibility(Preferences.showDockIcon)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let statusButton = statusBarItem.button else { return }
        
        statusButton.title = Preferences.showSeconds ? Date.now.stringTimeWithSeconds : Date.now.stringTime
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateStatusText),
            userInfo: nil,
            repeats: true
        )
        
        let statusMenu: NSMenu = {
            let menu = NSMenu()

            let messageItem: NSMenuItem = NSMenuItem(
                title: "Good \(Date.now.isMorning ? "Morning" : "Evening")",
                action: nil,
                keyEquivalent: ""
            )
            
            let toggleFlashingSeparatorsItem: NSMenuItem = {
                let item = NSMenuItem(
                    title: "Flashing separators",
                    action: #selector(toggleFlashingSeparators),
                    keyEquivalent: ""
                )
                
                item.tag = 1
                item.target = self
                item.state = Preferences.useFlashDots.stateValue
                
                return item
            }()
            
            let toggleDockIconItem: NSMenuItem = {
                let item = NSMenuItem(
                    title: "Toggle Dock Icon",
                    action: #selector(toggleDockIcon),
                    keyEquivalent: ""
                )
                
                item.tag = 2
                item.target = self
                item.state = Preferences.showDockIcon.stateValue
                
                return item
            }()
            
            let toggleSecondsItem: NSMenuItem = {
                let item = NSMenuItem(
                    title: "Show seconds",
                    action: #selector(toggleSeconds),
                    keyEquivalent: ""
                )
                
                item.tag = 3
                item.target = self
                item.state = Preferences.showSeconds.stateValue
                
                return item
            }()
            
            let remindersItem: NSMenuItem = {
                let item = NSMenuItem(title: "Reminders", action: nil, keyEquivalent: "")
                item.tag = 5
                
                let menu = NSMenu()
                
                for reminder in reminders {
                    menu.addItem(.init(title: reminder.title, action: nil, keyEquivalent: ""))
                }
                
                item.isEnabled = reminders.count > 0
                
                return item
            }()
            
            let quitApplicationItem: NSMenuItem = {
                let item = NSMenuItem(title: "Quit", action: #selector(terminate), keyEquivalent: "q")
                item.target = self
                item.tag = 4
                
                return item
            }()
            
            let addReminderItem: NSMenuItem = {
                let item = NSMenuItem(title: "New Reminder", action: #selector(addReminder), keyEquivalent: "")
                item.tag = 6
                item.target = self
                return item
            }()
            
            menu.addItems(
                messageItem,
                
                .separator(),
                
                remindersItem, // 5
                addReminderItem,  // 6
                
                .separator(),
                
                toggleFlashingSeparatorsItem, // 1
                toggleDockIconItem, // 2
                
                .separator(),
                
                toggleSecondsItem, // 3
                
                .separator(),
                
                quitApplicationItem // 4
            )
        
            return menu
        }()
        
        statusBarItem.menu = statusMenu
    }
}


/*
 * -----------------------
 * MARK: - Utilities
 * ------------------------
 */
extension AppDelegate {
    private func getRemindersMenu() -> NSMenu {
        let menu = NSMenu()
        
        for reminder in reminders {
            menu.addItem(.init(title: reminder.title, action: nil, keyEquivalent: ""))
        }
        
        return menu
    }
}

/*
 * -----------------------
 * MARK: - Actions
 * ------------------------
 */
extension AppDelegate {
    @objc
    func updateStatusText(_ sender: Timer) {
        guard let statusButton = statusBarItem.button else { return }
        var title: String = (Preferences.showSeconds ? Date.now.stringTimeWithSeconds : Date.now.stringTime)
        
        if Preferences.useFlashDots && Date.now.seconds % 2 == 0 {
            title = title.replacingOccurrences(of: ":", with: " ")
        }
        
        statusButton.title = title
    }
    
    @objc
    func toggleFlashingSeparators(_ sender: NSMenuItem) {
        Preferences.useFlashDots = !Preferences.useFlashDots
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 1) {
            item.state = Preferences.useFlashDots.stateValue
        }
    }
    
    
    @objc
    func toggleDockIcon(_ sender: NSMenuItem) {
        Preferences.showDockIcon = !Preferences.showDockIcon
        
        DockIcon.standard.setVisibility(Preferences.showDockIcon)
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 2) {
            item.state = Preferences.showDockIcon.stateValue
        }
    }
    
    @objc
    func toggleSeconds(_ sender: NSMenuItem) {
        Preferences.showSeconds = !Preferences.showSeconds
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 3) {
            item.title = "Show seconds"
            item.state = Preferences.showSeconds.stateValue
        }
    }
    
    @objc
    func terminate(_ sender: NSMenuItem) {
        NSApp.terminate(sender)
    }
    
    @objc
    func addReminder(_ sender: NSMenuItem) {
        if let vc = WindowsManager.getVC(withIdentifier: "NewReminderVC", ofType: NewReminderVC.self) {
            vc.delegate = self
            let window: NSWindow = {
                let w = NSWindow(contentViewController: vc)
                
                w.styleMask.remove(.fullScreen)
                w.styleMask.remove(.resizable)
                w.styleMask.remove(.miniaturizable)
                
                w.level = .floating
                
                return w
            }()
            
            if REMINDERS_WINDOW_CONTROLLER.window == nil {
                REMINDERS_WINDOW_CONTROLLER.window = window
            }
            
            REMINDERS_WINDOW_CONTROLLER.showWindow(self)
        }
    }
}

extension AppDelegate: NewReminderVCDelegate, ReminderDelegate {
    
    // On submit close the window and save the reminder
    func onSubmit(_ sender: NSButton, reminder: Reminder) {
        reminder.delegate = self
        if reminder.tag == nil {
            reminder.tag = reminders.count
        }
        
        REMINDERS_WINDOW_CONTROLLER.close()
        reminders.append(reminder)
    }
    
    // Once a reminder is fired, let's delete it
    func onReminderFired(_ reminder: Reminder) {
        reminders.removeAll(where: { $0.tag == reminder.tag })
    }
}
