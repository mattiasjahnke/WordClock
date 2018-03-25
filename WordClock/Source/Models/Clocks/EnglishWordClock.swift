//
//  EnglishWordClock.swift
//  WordClockApp
//
//  Created by Mattias Jähnke on 2018-03-25.
//  Copyright © 2018 Engineerish. All rights reserved.
//

import Foundation

struct EnglishWordClock: WordClock {
    private let raw =
    """
    ITHISLTENHALF
    QUARTERTWENTY
    FIVEOMINUTESV
    PASTTOEONETWO
    THREEFOURFIVE
    SIXSEVENEIGHT
    NINETENELEVEN
    TWELVEUOCLOCK
    """
    
    var width: Int {
        return raw.split(separator: "\n").first!.count
    }
    
    var height: Int {
        return raw.split(separator: "\n").count
    }
    
    func getResult(h: Int, m: Int) -> ClockResult {
        var layout = layoutFrom(raw: raw)
        var hour = h // To be modified
        
        if hour == 0 {
            hour = 12
        }
        
        func set(_ x: Int, _ y: Int, _ value: Bool = true, count: Int = 1) {
            for i in x..<x+count {
                layout[y][i].1 = value
            }
        }
        
        
        func minutes() { set(5, 2, count: 7) } // MINUTES
        func twenty() { set(7, 1, count: 6) } // TWENTY
        func five() { set(0, 2, count: 4) } // FIVE
        
        // IT IS
        set(0, 0, count: 2)
        set(3, 0, count: 2)
        
        switch m {
        case 0..<5:
            set(7, 7, count: 6) // O CLOCK
        case 5..<10, 55..<60:
            five()              // FIVE
            minutes()           // MINUTES
        case 10..<15, 50..<55:
            set(6, 0, count: 3) // TEN
            minutes()           // MINUTES
        case 15..<20, 45..<50:
            set(0, 1, count: 7) // QUARTER
        case 20..<25, 40..<45:
            twenty()            // TWENTY
            minutes()           // MINUTES
        case 25..<30, 35..<40:
            twenty()
            five()
            minutes()
        default:
            break
        }
        
        // HALF
        if 30..<35 ~= m { set(9, 0, count: 4) }
        
        // PAST
        if 5..<35 ~= m { set(0, 3, count: 4) }
        
        // TO
        if m >= 35 {
            set(4, 3, count: 2)
            hour += 1
            
            if hour == 13 {
                hour = 1
            }
        }

        switch hour {
        case 1: set(7, 3, count: 3)
        case 2: set(10, 3, count: 3)
        case 3: set(0, 4, count: 5)
        case 4: set(5, 4, count: 4)
        case 5: set(9, 4, count: 4)
        case 6: set(0, 5, count: 3)
        case 7: set(3, 5, count: 5)
        case 8: set(8, 5, count: 5)
        case 9: set(0, 6, count: 4)
        case 10: set(4, 6, count: 3)
        case 11: set(7, 6, count: 6)
        case 12: set(0, 7, count: 6)
        default: break
        }
        
        return layout
    }
}
