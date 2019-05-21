//
//  Int+Extension.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Foundation

extension Int {
    /// ---
    ///     var n: Int = 5
    ///     n = n.safeString
    ///     print(n)  // "05"
    /// ---
    var safeString: String {
        return self >= 10 ? "\(self)" : "0\(self)"
    }
}
