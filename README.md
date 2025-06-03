# DirectusAPIMacros

Swift Macros for use within the [DirectusAPI](https://github.com/cedric06nice/DirectusAPI) package.

---

## 📦 Overview

This package provides Swift 6.1 macros to simplify working with models and collections in [DirectusAPI](https://github.com/cedric06nice/DirectusAPI). It includes:

- `@DirectusClassRegistration`: Auto-generates `collectionMetadata` and an initializer for your data model.
- `@DirectusAddToCollectionList`: Auto-registers a set of `DirectusCollection` types at runtime.

These macros eliminate boilerplate and enforce structure when modeling Directus-compatible content types in Swift.

---

## 🚫 Usage Limitation

> ⚠️ This package **cannot be used independently**.

It is **tightly coupled to** and **designed to be used only within** the [`DirectusAPI`](https://github.com/cedric06nice/DirectusAPI) ecosystem. Installing it directly will result in missing types or build errors.

---

## 🧭 Looking for Directus Swift Integration?

Visit 👉 [**DirectusAPI on GitHub**](https://github.com/cedric06nice/DirectusAPI)

There you'll find:
- The full Swift client implementation
- Usage examples
- How to register and use macros like `@DirectusClassRegistration`
- Complete documentation and test coverage

---

## 🧑‍💻 Example (from DirectusAPI)

```swift
@DirectusClassRegistration(endpointName: "roles")
final class DirectusRole: DirectusData, DirectusCollection {
    var name: String
    var description: String?
    var users: [String]
}
```
And in the app entry point:

```swift
@DirectusAddToCollectionList(DirectusRole.self)
@main
struct MyApp: App { ... }
```
