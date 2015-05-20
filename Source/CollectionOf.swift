//
//  CollectionOf.swift
//  Erasure
//
//  Created by Neil Pankey on 5/20/15.
//  Copyright (c) 2015 Neil Pankey. All rights reserved.
//

/// A type-erased collection type.
public struct CollectionOf<T, I: ForwardIndexType>: CollectionType {
    private let _generate: () -> GeneratorOf<T>
    private let _subscript: (I) -> T
    private let _startIndex: () -> I
    private let _endIndex: () -> I

    public init<C: CollectionType where C.Generator.Element == T, C.Index == I>(_ base: C) {
        _generate = { GeneratorOf(base.generate()) }
        _startIndex = { base.startIndex }
        _endIndex = { base.endIndex }
        _subscript = { base[$0] }
    }

    public func generate() -> GeneratorOf<T> {
        return _generate()
    }

    public var startIndex: I {
        return _startIndex()
    }

    public var endIndex: I {
        return _endIndex()
    }

    public subscript (i: I) -> T {
        return _subscript(i)
    }
}
