//
//  WindowsManager.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Foundation
import AppKit

struct WindowsManager {
    static func getVC<T: NSViewController>(withIdentifier identifier: String, ofType: T.Type?, storyboard: String = "Main", bundle: Bundle? = nil) -> T? {
        let storyboard = NSStoryboard(name: storyboard, bundle: bundle)
        
        guard let vc: T = storyboard.instantiateController(withIdentifier: identifier) as? T else {
            let alert = NSAlert()
            alert.alertStyle = .critical
            alert.messageText = "Error initiating the viewcontroller"
            alert.runModal()
            
            return nil
        }
        
        return vc
    }
}
