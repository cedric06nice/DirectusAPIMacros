// The Swift Programming Language
// https://docs.swift.org/swift-book

/// Implementation of the `@DirectusClassRegistration` macro
/// Use on a class conforming to both `DirectusData` and
/// `DirectusCollection` protocols.
///
/// Use the macro as follow:
///
///     @DirectusClassRegistration(
///         endpointName: String,
///         defaultFields: String = "*",
///         endpointPrefix: String = "/items/",
///         webSocketEndPoint: String? = nil,
///         defaultUpdateFields: String? = nil)
///     class YourClass: DirectusData, DirectusCollection {
///         var name: String
///         var description: String?
///         var children: [String]
///     }
///
/// Do not forget to add the class to the CollectionList on the `main` view
/// to avoid any crashes.
///
///     @DirectusAddToCollectionList(Class1.self, ...)
///
@attached(
    member,
    conformances: DirectusDataCollection,
    names: named(collectionMetadata), named(DirectusDataCollection), named(_register), named(init(_:))
)
public macro DirectusClassRegistration(
    endpointName: String,
    defaultFields: String = "*",
    endpointPrefix: String = "/items/",
    webSocketEndPoint: String? = nil,
    defaultUpdateFields: String? = nil
) = #externalMacro(
    module: "DirectusAPIMacrosMacros",
    type: "DirectusClassRegistration"
)

protocol DirectusDataCollection {}

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
@attached(member, names: named(_register))
public macro DirectusAddToCollectionList(_: Any...) = #externalMacro(
    module: "DirectusAPIMacrosMacros",
    type: "DirectusAddToCollectionList"
)
