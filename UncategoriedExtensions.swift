//
//  UncategoriedExtensions.swift
//  Extenz
//
//  Created by Jesse Hao on 2019/6/4.
//

import Foundation

// MARK: - UnsafePointer
public extension UnsafePointer where Pointee == Int8 {
    var string:String { return String(cString: self) }
}
