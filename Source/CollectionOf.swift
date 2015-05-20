//
//  CollectionOf.swift
//  Erasure
//
//  Created by Neil Pankey on 5/20/15.
//  Copyright (c) 2015 Neil Pankey. All rights reserved.
//

/// A type-erased collection type.
public struct CollectionOf<T, Index: ForwardIndexType>: CollectionType {
    private let _generate: () -> GeneratorOf<T>
    private let _subscript: (Index) -> T
    private let _startIndex: () -> Index
    private let _endIndex: () -> Index

    public init<C: CollectionType where C.Generator.Element == T, C.Index == Index>(_ base: C) {
        _generate = { GeneratorOf(base.generate()) }
        _startIndex = { base.startIndex }
        _endIndex = { base.endIndex }
        _subscript = { base[$0] }
    }

    public func generate() -> GeneratorOf<T> {
        return _generate()
    }

    public var startIndex: Index {
        return _startIndex()
    }

    public var endIndex: Index {
        return _endIndex()
    }

    public subscript (index: Index) -> T {
        return _subscript(index)
    }
}
