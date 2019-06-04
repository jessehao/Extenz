//
//  FoundationExtensions.swift
//  Extenz
//
//  Created by Jesse Hao on 2019/6/4.
//

public extension NSRange {
    static var zero:NSRange { return NSRange(location: 0, length: 0) }
    var nilIfNotFound:NSRange? { return self.location == NSNotFound ? nil : self }
}

public extension NSString {
    func rangeOrNil(of searchString: String, options mask: NSString.CompareOptions = [], range rangeOfReceiverToSearch: NSRange? = nil, locale: Locale? = nil) -> NSRange? {
        if let searchRange = rangeOfReceiverToSearch {
            if let locale = locale {
                return self.range(of:searchString, options:mask, range: searchRange, locale:locale).nilIfNotFound
            }
            return self.range(of:searchString, options:mask, range: searchRange).nilIfNotFound
        }
        return self.range(of:searchString, options:mask).nilIfNotFound
    }
}
