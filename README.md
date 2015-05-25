# Erasure [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
Missing type-erased collections for Swift

## Immutable

```swift
struct CollectionOf<T, Index: ForwardIndexType>: CollectionType
```

A type-erased collection implemenation.

```swift
struct SliceableOf<T, Index: ForwardIndexType>: Sliceable 
```

A type-erased sliceable collection. Useful for cases like `Array` and `ArraySlice` where the slice type differs from the root type.

## Mutable

The mutable variants are mostly proof-of-concept and of limited real world value

```swift
struct MutableCollectionOf<T, Index: ForwardIndexType>: MutableCollectionType 
```

The mutable equivalent of `CollectionOf`.

```swift
struct ExtensibleCollectionOf<T>: ExtensibleCollectionType
```

A type-erased `ExtensibleCollectionType`, limited to `Int` indices.

## License
Euclid is released under the [MIT license](LICENSE)
