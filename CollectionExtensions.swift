//
//  CollectionExtensions.swift
//  Extenz
//
//  Created by Jesse Hao on 2019/6/4.
//

import Foundation

public extension Sequence {
    func array() -> [Element] {
        return Array(self)
    }
}

public extension Sequence where Element : Hashable {
    func set() -> Set<Element> {
        return Set(self)
    }
}

extension Zip2Sequence where Sequence1.Element : Hashable {
    func dictionary() -> [Sequence1.Element : Sequence2.Element] {
        return Dictionary(uniqueKeysWithValues: self)
    }
}

public extension Collection {
    func element(at index:Self.Index) -> Element? {
        guard (self.startIndex..<self.endIndex).contains(index) else { return nil }
        return self[index]
    }
}

public extension Collection where Element == Bool {
    func and() -> Bool {
        guard self.count > 0 else { return false }
        for i in self {
            if i == false { return false }
        }
        return true
    }
    
    func or() -> Bool {
        for i in self {
            if i == true { return true }
        }
        return false
    }
}

extension Collection where Self.Index == Int {
    func first(_ k: Int) -> Self.SubSequence {
        guard k >= 0 else { return self.last(-k) }
        return self[0..<k.trimmed(max: self.count)]
    }
    
    func last(_ k: Int) -> Self.SubSequence {
        guard k >= 0 else { return self.first(-k) }
        let startIndex = self.count - k.trimmed(max: self.count)
        return self[startIndex..<self.count]
    }
}

extension Collection where Index == Int, Element : Collection, Element.Index == Int {
    subscript(indexPath:IndexPath) -> Element.Element {
        return self[indexPath.section][indexPath.row]
    }
}

public extension RangeReplaceableCollection {
    mutating func replaceAll(with value:Element) {
        self = Self(repeating: value, count: self.count)
    }
    
    @discardableResult
    mutating func appendIfNonnull(_ newElement: Element?) -> Bool {
        if let new = newElement {
            self.append(new)
            return true
        }
        return false
    }
    
    @discardableResult
    mutating func appendIfNonnull<S:Sequence>(contentsOf newElements: S?) -> Bool where Self.Element == S.Element {
        if let new = newElements {
            self.append(contentsOf: new)
            return true
        }
        return false
    }
    
    mutating func appendIfElementNonnull<S:Sequence>(contentsOf newElements: S) where S.Element == Self.Element? {
        self.append(contentsOf: newElements.compactMap { $0 })
    }
    
    static func += (collection:inout Self, newElement:Element) {
        collection.append(newElement)
    }
}

public extension RangeReplaceableCollection where Element : Equatable {
    @discardableResult
    mutating func remove(_ element:Element) -> Bool {
        guard let index = self.index(of: element) else { return false }
        self.remove(at: index)
        return true
    }
    
    @discardableResult
    mutating func appendUnique(_ newElement:Element) -> Bool {
        guard !(self.contains { $0 == newElement }) else { return false }
        self.append(newElement)
        return true
    }
}

public extension RangeReplaceableCollection where Index : Hashable {
    mutating func remove(withIndexSet set:Set<Index>) {
        set.forEach { self.remove(at: $0) }
    }
}

extension Array where Element == String {
    var forPredicate:String {
        return self.map { $0.forPredicate }.joined(separator: ",").stringWith(prefix: "{", suffix: "}")
    }
}

extension Array where Element : LosslessStringConvertible {
    var forPredicate:String {
        return self.map { $0.string }.joined(separator: ",").stringWith(prefix: "{", suffix: "}")
    }
}
