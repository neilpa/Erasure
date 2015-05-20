//
//  SliceableOf.swift
//  Erasure
//
//  Created by Neil Pankey on 5/20/15.
//  Copyright (c) 2015 Neil Pankey. All rights reserved.
//

/// A type-erased sliceable collection. Requires that recursive sub-slices
/// are the same concrete type.
///
/// Most useful for generically using collections where the slice type differs
/// from the root collection (e.g. Array vs ArraySlice).
public struct SliceableOf<T, Index: ForwardIndexType>: Sliceable {
    private let _generate: () -> GeneratorOf<T>
    private let _startIndex: () -> Index
    private let _endIndex: () -> Index
    private let _subscript: (Index) -> T
    private let _range: (Range<Index>) -> SliceableOf<T, Index>

    public init<C: Sliceable where
        C.SubSlice: Sliceable, C.SubSlice == C.SubSlice.SubSlice,
        C.Generator.Element == T, C.SubSlice.Generator.Element == T,
        C.Index == Index, C.SubSlice.Index == Index
    >(_ base: C) {
        _generate = { GeneratorOf(base.generate()) }
        _startIndex = { base.startIndex }
        _endIndex = { base.endIndex }
        _subscript = { base[$0] }
        _range = { SliceableOf(base[$0]) }
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

    public subscript(index: Index) -> T {
        return _subscript(index)
    }

    public subscript(bounds: Range<Index>) -> SliceableOf<T, Index> {
        return _range(bounds)
    }
}
