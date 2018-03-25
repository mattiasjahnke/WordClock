//
//  WordClock.swift
//  WordClock
//
//  Created by Mattias Jähnke on 2018-03-24.
//  Copyright © 2018 Engineerish. All rights reserved.
//

import Foundation

typealias WordClockCell = (Character, Bool)
typealias ClockResult = [[WordClockCell]]

protocol WordClock {
    var width: Int { get }
    var height: Int { get }
    func getResult(h: Int, m: Int) -> ClockResult
}

extension WordClock {
    func getResult(time: Date) -> ClockResult {
        let comp = Calendar.current.dateComponents([.hour, .minute], from: time)
        return getResult(h: (comp.hour ?? 0) % 12, m: comp.minute ?? 0)
    }
    
    func layoutFrom(raw: String) -> ClockResult {
        return raw.split(separator: "\n").map { Array($0).map { ($0, false) } }
    }
}

enum Language: Int {
    case en
}

func getClock(language: Language) -> WordClock {
    switch language {
    case .en:
        return EnglishWordClock()
    }
}
