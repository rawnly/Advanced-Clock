//
//  DockIcon.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Foundation
import AppKit

struct DockIcon {
    static var standard = DockIcon()
    
    var isVisible: Bool {
        get {
            return NSApp.activationPolicy() == .regular
        }
        
        set {
            setVisibility(isVisible)
        }
    }
    
    @discardableResult
    func setVisibility(_ state: Bool) -> Bool {
        if state {
            NSApp.setActivationPolicy(.regular)
        } else {
            NSApp.setActivationPolicy(.accessory)
        }
        
        return isVisible
    }
}
