import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

#if canImport(DirectusAPIMacrosImpl)
@testable import DirectusAPIMacrosImpl

let testDirectusClassRegistrationMacro: [String: Macro.Type] = [
    "DirectusClassRegistration": DirectusClassRegistration.self
]

let testDirectusAddToCollectionListMacro: [String: Macro.Type] = [
    "DirectusAddToCollectionList": DirectusAddToCollectionList.self
]
#endif

@Suite("DirectusAPIMacrosTests")
final class DirectusAPIMacrosTests {
    
    @Test("DirectusClassRegistration")
    func testDirectusClassRegistration() throws {
        #if canImport(DirectusAPIMacrosImpl)
        assertMacroExpansion(
            """
            @DirectusClassRegistration(endpointName: "roles", endpointPrefix: "/")
            class TestingMacro: Codable {
                var name: String
                var icon: String
                var description: String?
                var policies: [String]
                var parent: String?
                var children: [String]
                var users: [String]
            }
            """,
            expandedSource: """
            class TestingMacro: DirectusData, DirectusCollection, Codable {
                var name: String
                var icon: String
                var description: String?
                var policies: [String]
                var parent: String?
                var children: [String]
                var users: [String]
            
                // Expended macro DirectusClassRegistration
                public static let _register: Void = {
                    CollectionMetadataRegistry.register(TestingMacro.self)
                }()
            }
            """,
            macros: testDirectusClassRegistrationMacro
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // This cannot be tested at runtime - Will always pass
    @Test("DirectusClassRegistration on a struct")
    func testDirectusClassRegistrationOnAStruct() throws {
        #if canImport(DirectusAPIMacrosImpl)
        assertMacroExpansion(
            """
            @DirectusClassRegistration
            struct TestingMacro {
                let constant: String
            }
            """,
            expandedSource: """
            struct TestingMacro {
                let constant: String
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@DirectusClassRegistration can only be applied to classes", line: 1, column: 1)
            ],
            macros: testDirectusClassRegistrationMacro
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // This cannot be tested at runtime - Will always pass
    @Test("DirectusClassRegistration on a class not conforming to DirectusCollection")
    func testRegisterCollectionOnClassNonConformingToDirectusCollection() throws {
        #if canImport(DirectusAPIMacrosImpl)
        assertMacroExpansion(
            """
            @DirectusClassRegistration
            class TestingMacro {
                let constant: String
            }
            """,
            expandedSource: """
            class TestingMacro {
                let constant: String
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@DirectusClassRegistration can only be applied to class conforming to protocol 'DirectusCollection'", line: 1, column: 1)
            ],
            macros: testDirectusClassRegistrationMacro
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // This cannot be tested at runtime - Will always pass
    @Test("DirectusAddToCollectionList")
    func testDirectusAddToCollectionList() throws {
        #if canImport(DirectusAPIMacrosImpl)
        assertMacroExpansion(
            """
            @DirectusAddToCollectionList(Test1.self, Test2.self, Test3.self)
            struct TestingMacro {
                let constant: String
            }
            """,
            expandedSource: """
            struct TestingMacro {
                let constant: String
                
                let _ = Test1._register
                let _ = Test2._register
                let _ = Test3._register
            }
            """,
            macros: testDirectusAddToCollectionListMacro
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
