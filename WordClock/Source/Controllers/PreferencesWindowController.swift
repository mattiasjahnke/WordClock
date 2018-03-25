//
//  PreferencesWindowController.swift
//  WordClock
//
//  Created by Mattias Jähnke on 2018-03-25.
//  Copyright © 2018 Engineerish. All rights reserved.
//

import Cocoa

@objc(PreferencesWindowController)
class PreferencesWindowController: NSWindowController {
    @IBOutlet weak var rowWidthSegment: NSSegmentedControl!
    @IBOutlet weak var languageButton: NSPopUpButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        languageButton.selectItem(at: Preferences.language.rawValue)
        rowWidthSegment.selectedSegment = Preferences.rowWidth.rawValue
    }
    
    @IBAction func languageChanged(_ sender: Any) {
        Preferences.language = Language(rawValue: languageButton.indexOfSelectedItem)!
    }
    
    @IBAction func close(_ sender: Any) {
        guard let window = window else { return }
        NSApp.mainWindow?.endSheet(window)
    }
    
    @IBAction func rowWidthChanged(_ sender: Any) {
        if rowWidthSegment.selectedSegment == 0 {
            Preferences.rowWidth = .dynamic
        } else {
            Preferences.rowWidth = .`static`
        }
    }
}
