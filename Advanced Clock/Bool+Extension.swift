//
//  Bool+Extension.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Foundation
import AppKit

extension Bool {
    var stateValue: NSControl.StateValue {
        return self.toStateValue()
    }
    
    private func toStateValue() -> NSControl.StateValue {
        return self ? .on : .off
    }
}
