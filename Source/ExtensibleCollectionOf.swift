//
//  ExtensibleCollectionOf.swift
//  Erasure
//
//  Created by Neil Pankey on 5/20/15.
//  Copyright (c) 2015 Neil Pankey. All rights reserved.
//

/// A type-erased collection that supports effecient append. Requires `Int` indexes.
public struct ExtensibleCollectionOf<T>: ExtensibleCollectionType {
    private let _generate: () -> GeneratorOf<T>
    private let _startIndex: () -> Int
    private let _endIndex: () -> Int
    private let _subscript: (Int) -> T

    private let _reserve: (Int) -> ()
    private let _append: (T) -> ()
    private let _extend: (SequenceOf<T>) -> ()

    public init() {
        self.init([])
    }

    public init<C: ExtensibleCollectionType where C.Generator.Element == T, C.Index == Int>(var _ base: C) {
        _generate = { GeneratorOf(base.generate()) }
        _startIndex = { base.startIndex }
        _endIndex = { base.endIndex }
        _subscript = { base[$0] }

        _reserve = { base.reserveCapacity($0) }
        _append = { base.append($0) }
        _extend = { base.extend($0) }
    }

    public func generate() -> GeneratorOf<T> {
        return _generate()
    }

    public var startIndex: Int {
        return _startIndex()
    }

    public var endIndex: Int {
        return _endIndex()
    }

    public subscript(index: Int) -> T {
        return _subscript(index)
    }

    public mutating func reserveCapacity(minimumCapacity: Int) {
        _reserve(minimumCapacity)
    }

    public mutating func append(x: T) {
        _append(x)
    }

    public mutating func extend<S : SequenceType where S.Generator.Element == T>(newElements: S) {
        _extend(SequenceOf(newElements))
    }
}
