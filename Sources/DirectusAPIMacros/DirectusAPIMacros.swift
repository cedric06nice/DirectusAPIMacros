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
    names: named(collectionMetadata), named(_register), named(init(_:))
)
public macro DirectusClassRegistration(
    endpointName: String,
    defaultFields: String = "*",
    endpointPrefix: String = "/items/",
    webSocketEndPoint: String? = nil,
    defaultUpdateFields: String? = nil
) = #externalMacro(
    module: "DirectusAPIMacrosImpl",
    type: "DirectusClassRegistration"
)

/// Implementation of the `@DirectusAddToCollectionList()` macro
/// to register the class.
///
/// Prefix the main view with the macro and add
/// `MetadataFactory.registerDirectusCollections()`
/// to the task modifier of the inside view
///
///     @DirectusAddToCollectionList(Class1.self, ...)
///     @main
///     struct MyApp: App {
///         var body: some Scene {
///             WindowGroup {
///                 Group {
///                     ContentView()
///                         .task {
///                             MetadataFactory.registerDirectusCollections()
///                         }
///                 }
///             }
///         }
///     }
///
/// Add all the classes prefixed with the `@DirectusClassRegistration` macro.
///
@attached(member, names: named(body))
public macro DirectusAddToCollectionList(_: Any...) = #externalMacro(
    module: "DirectusAPIMacrosImpl",
    type: "DirectusAddToCollectionList"
)
