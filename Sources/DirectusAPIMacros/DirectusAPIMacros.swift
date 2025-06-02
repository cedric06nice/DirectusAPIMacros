// The Swift Programming Language
// https://docs.swift.org/swift-book

/// Implementation of the `@DirectusClassRegistration` macro
/// Use on a class conforming to `DirectusCollection` protocol
/// to register the class.
///
/// Use the macro as follow:
///
///     @DirectusClassRegistration
///     class YourClass: DirectusCollection {}
///
/// Do not forget to add the class to the CollectionList on the `main` view
/// to avoid any crashes.
///
///     @DirectusAddToCollectionList(Class1.self, ...)
///
@attached(member, names: named(_register))
public macro DirectusClassRegistration() = #externalMacro(
    module: "DirectusAPIMacrosMacros",
    type: "DirectusClassRegistration"
)

/// Implementation of the `@DirectusAddToCollectionList()` macro
/// to register the class.
///
/// Use the macro as follow:
///
///     @DirectusAddToCollectionList(Class1.self, ...)
///     @main
///     struct MyApp: App {}
///
/// Add all the classes prefixed with the `@DirectusClassRegistration` macro.
///
@attached(member)
public macro DirectusAddToCollectionList(_: Any...) = #externalMacro(
    module: "DirectusAPIMacrosMacros",
    type: "DirectusAddToCollectionList"
)
