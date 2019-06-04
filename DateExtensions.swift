//
//  DateExtensions.swift
//  Extenz
//
//  Created by Jesse Hao on 2019/6/4.
//

import Foundation

// MARK: - Date
public extension Date {
    static let microsecondsPerSecond:UInt32 = 1000000
    func string(withFormat format:String) -> String {
        return DateFormatter.shared.string(from: self, format: format)
    }
}

public extension DateFormatter {
    func date(from raw:String, format:String) -> Date? {
        defer { self.dateFormat = self.dateFormat.string }
        self.dateFormat = format
        return self.date(from: raw)
    }
    
    func string(from date:Date, format:String) -> String {
        defer { self.dateFormat = self.dateFormat.string }
        self.dateFormat = format
        return self.string(from: date)
    }
}

// MARK: Namespaced
public extension DateFormatter {
    static let shared = DateFormatter()
    static let defaultDateStringParsingSet:Set<String> = [
        "y/MM/dd",
        "y-MM-dd",
        "y-MM"
    ]
}
