import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum RegisterCollectionError: CustomStringConvertible, Error {
    case onlyApplicableToClasses
    case notConformingToProtocol(String)
    
    var description: String {
        switch self {
        case .onlyApplicableToClasses: return "@DirectusClassRegistration can only be applied to classes"
        case .notConformingToProtocol(let name): return "@DirectusClassRegistration can only be applied to class conforming to protocol '\(name)'"
        }
    }
}

/// Implementation of the `DirectusClassRegistration` macro
struct DirectusClassRegistration: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
            throw RegisterCollectionError.onlyApplicableToClasses
        }
        var protocols: [String] = []
        if let protocolsConformance: InheritedTypeListSyntax = classDecl.inheritanceClause?.inheritedTypes {
            _ = protocolsConformance.map { type in
                if let syn = type.type.as(IdentifierTypeSyntax.self) {
                    protocols.append(String(syn.name.text))
                }
            }
        }
        if protocols.isEmpty
            || protocols.contains(where: { $0 != "DirectusCollection" }) {
            throw RegisterCollectionError.notConformingToProtocol("DirectusCollection")
        }
        let className = classDecl.name.text
        let registerContent: DeclSyntax =
            """
            
            // Expended macro DirectusClassRegistration
            @MainActor
            public static let _register: Void = {
                CollectionMetadataRegistry.register(\(raw: className).self)
            }()
            """
        return [
            registerContent
        ]
    }
}

/// Implementation of the `DirectusAddToCollectionList` macro
struct DirectusAddToCollectionList: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        var arguments: [DeclSyntax] = [
            DeclSyntax(stringLiteral: "// Expended macro DirectusAddToCollectionList")
        ]
        var removeDuplicates: Set<String> = []
        guard let providedArguments = node.arguments?.as(LabeledExprListSyntax.self) else {
            return []
        }
        _ = providedArguments.compactMap { (list: LabeledExprSyntax) in
            let trimmedDescription = list.expression.description.replacingOccurrences(of: ".self", with: "")
            if !removeDuplicates.contains(trimmedDescription) {
                removeDuplicates.insert(trimmedDescription)
                arguments.append(DeclSyntax(stringLiteral: "let _ = \(trimmedDescription)._register"))
            }
        }
        return arguments
    }
}

@main
struct DirectusAPIMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DirectusClassRegistration.self,
        DirectusAddToCollectionList.self
    ]
}
