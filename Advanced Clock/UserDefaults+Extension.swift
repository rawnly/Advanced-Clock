//
//  Preferences.swift
//  Advanced Clock
//
//  Created by Federico Vitale on 20/05/2019.
//  Copyright © 2019 Federico Vitale. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case useFlashDots = "useFlashDots"
        case showSeconds = "showSeconds"
        case showDockIcon = "showDockIcon"
        case firstRunGone = "firstRunGone"
    }
    
    func set<T>(_ value: T, forKey key: Key) {
        set(value, forKey: key.rawValue)
    }
    
    func bool(forKey key: Key) -> Bool {
        return bool(forKey: key.rawValue)
    }
    
    func string(forKey key: Key) -> String? {
        return string(forKey: key.rawValue)
    }
    
    func integer(forKey key: Key) -> Int? {
        return integer(forKey: key.rawValue)
    }
    
    func url(forKey key: Key) -> URL? {
        return url(forKey: key.rawValue)
    }
}
