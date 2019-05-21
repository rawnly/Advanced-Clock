//
//  NSMenu+Extension.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Foundation
import AppKit

extension NSMenu {
    func addSeparator() -> Void {
        addItem(.separator())
    }
    
    func addItems(_ items: NSMenuItem...) {
        for item in items {
            addItem(item)
        }
    }
}
