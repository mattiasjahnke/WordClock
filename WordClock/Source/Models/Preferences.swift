//
//  Preferences.swift
//  WordClock
//
//  Created by Mattias Jähnke on 2018-03-25.
//  Copyright © 2018 Engineerish. All rights reserved.
//

import Foundation
import ScreenSaver

private var userDefaults: UserDefaults = {
    let ud =  ScreenSaverDefaults(forModuleWithName: "com.engineerish.WordClock") ?? UserDefaults()
    
    ud.register(defaults: [
        Preferences.Key.rowWidth.rawValue: Preferences.RowWidth.dynamic.rawValue,
        Preferences.Key.language.rawValue: Language.en.rawValue
        ])
    
    return ud
}()

struct Preferences {
    fileprivate enum Key: String {
        case rowWidth = "rowWidth-type"
        case language = "language"
    }
    
    enum RowWidth: Int {
        case dynamic
        case `static`
    }
    
    static var rowWidth: RowWidth {
        get {
            guard let width = RowWidth(rawValue: userDefaults.integer(forKey: Key.rowWidth.rawValue)) else { return .dynamic }
            return width
        }
        set {
            set(value: newValue.rawValue, key: .rowWidth)
        }
    }
    
    static var language: Language {
        get {
            guard let language = Language(rawValue: userDefaults.integer(forKey: Key.language.rawValue)) else { return .en }
            return language
        }
        set {
            set(value: newValue.rawValue, key: .language)
        }
    }
    
    private static func set(value: Any, key: Key) {
        userDefaults.set(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }
}
