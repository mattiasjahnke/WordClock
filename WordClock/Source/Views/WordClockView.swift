//
//  WordClockView.swift
//  WordClock
//
//  Created by Mattias Jähnke on 2018-03-24.
//  Copyright © 2018 Engineerish. All rights reserved.
//

import Foundation
import ScreenSaver
import CoreText

@objc(WordClockView)
class WordClockView: ScreenSaverView {
    
    var preferencesController: PreferencesWindowController?
    let masterStack = NSStackView()
    
    var clock: WordClock? {
        didSet {
            if let clock = clock {
                rebuildStackGrid(width: clock.width, height: clock.height)
            }
        }
    }
    
    // MARK: - Preferences
    override var hasConfigureSheet: Bool {
        return true
    }
    
    override var configureSheet: NSWindow? {
        if let controller = preferencesController {
            return controller.window
        }
        
        let controller = PreferencesWindowController(windowNibName: NSNib.Name(rawValue: "PreferencesWindow"))
        
        preferencesController = controller
        return controller.window
    }
    
    var timer: Timer!
    
    // Debug
    let debug = false
    var h = 8, m = 30

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        self.animationTimeInterval = 1.0 / 30.0
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    deinit {
        timer.invalidate()
        print("deinit WordClockView")
    }
    
    func rebuildStackGrid(width: Int, height: Int) {
        // Clean up if we already have UI layed out
        while !masterStack.arrangedSubviews.isEmpty {
            masterStack.removeArrangedSubview(masterStack.arrangedSubviews.first!)
        }
        
        // Create the stack for each row and the text fields within them
        for _ in 0..<height {
            let rowStack = NSStackView()
            rowStack.distribution = .fillEqually
            rowStack.translatesAutoresizingMaskIntoConstraints = false
            for _ in 0..<width {
                let textField = NSTextField()
                textField.isEditable = false
                textField.textColor = .white
                textField.backgroundColor = .clear
                textField.textColor = .white
                textField.isBordered = false
                textField.stringValue = "Q"
                textField.alignment = .center
                textField.alphaValue = 0.2
                textField.font = NSFont.boldSystemFont(ofSize: 106)
                textField.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
                rowStack.addArrangedSubview(textField)
            }
            masterStack.addArrangedSubview(rowStack)
            /*if Preferences.rowWidth == .`static` {
                rowStack.widthAnchor.constraint(equalTo: masterStack.widthAnchor).isActive = true
            }*/
        }
    }
    
    func populateStackGrid(clockMatrix: ClockResult) {
        
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 1
        
        for y in 0..<clockMatrix.count {
            let rowStack = masterStack.arrangedSubviews[y] as! NSStackView
            for x in 0..<clockMatrix[y].count {
                let textField = rowStack.arrangedSubviews[x] as! NSTextField
                let (char, lit) = clockMatrix[y][x]
                textField.stringValue = "\(char)"
                textField.animator().alphaValue = lit ? 1 : 0.2
            }
        }
        
        NSAnimationContext.endGrouping()
    }
    
    func refreshTime() {
        guard let clock = clock else { return }
        populateStackGrid(clockMatrix: debug ? clock.getResult(h: h, m: m) : clock.getResult(time: Date()))
    }
    
    func setup() {
        clock = getClock(language: Preferences.language)
        
        masterStack.translatesAutoresizingMaskIntoConstraints = false
        masterStack.orientation = .vertical
        masterStack.distribution = .fillEqually
        addSubview(masterStack)
        
        masterStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        masterStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        masterStack.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 20).isActive = true
        masterStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 20).isActive = true
        
        masterStack.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 20).isActive = true
        masterStack.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: 20).isActive = true

        refreshTime()

        timer = Timer.scheduledTimer(withTimeInterval: debug ? 0.2 : 1, repeats: true) { _ in
            if self.debug {
                self.m += 1
                if self.m == 60 {
                    self.m = 0
                    self.h += 1
                    if self.h == 13 {
                        self.h = 0
                    }
                }
            }
            DispatchQueue.main.async {
                self.refreshTime()
            }
        }
    }
}
