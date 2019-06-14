//
//  StringExtensions.swift
//  Extenz
//
//  Created by Jesse Hao on 2019/6/4.
//

public extension String {
    mutating func add(suffix:String) { self += suffix }
    mutating func add(prefix:String) { self = prefix + self }
    func stringWith(suffix:String) -> String { return self + suffix }
    func stringWith(prefix:String) -> String { return prefix + self }
    func stringWith(prefix:String, suffix:String) -> String { return "\(prefix)\(self)\(suffix)" }
}

public extension String {
    func attributedString(withAttributes attributes:[NSAttributedString.Key:Any]) -> NSAttributedString { return NSAttributedString(string: self, attributes: attributes) }
    func mutableAttributedString(withAttributes attributes:[NSAttributedString.Key:Any]) -> NSMutableAttributedString { return NSMutableAttributedString(string: self, attributes: attributes) }
    func attributedStringFromHTML() -> NSAttributedString? {
        guard let data = self.data(using: .unicode) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
}

public extension String {
    var localized:String { return NSLocalizedString(self, comment: "") }
    
    func date(withFormat format:String? = nil) -> Date? {
        if let format = format {
            return DateFormatter.shared.date(from: self, format: format)
        }
        for format in  DateFormatter.defaultDateStringParsingSet {
            if let date = DateFormatter.shared.date(from: self, format: format) {
                return date
            }
        }
        return nil
    }
    
    func withFormatArguments(_ args:CVarArg...) -> String {
        return String(format: self, arguments: args)
    }
    
    var forPredicate:String {
        return self.stringWith(prefix: "'", suffix: "'")
    }
    
    var url:URL? {
        return URL(string: self)
    }
}

public extension StringProtocol {
    var int:Int? { return Int(self) }
    var int8:Int8? { return Int8(self) }
    var int16:Int16? { return Int16(self) }
    var int32:Int32? { return Int32(self) }
    var int64:Int64? { return Int64(self) }
    var uint:UInt? { return UInt(self) }
    var uint8:UInt8? { return UInt8(self) }
    var uint16:UInt16? { return UInt16(self) }
    var uint32:UInt32? { return UInt32(self) }
    var uint64:UInt64? { return UInt64(self) }
    var double:Double? { return Double(self) }
}

public extension LosslessStringConvertible {
    var string:String { return String(self) }
}
