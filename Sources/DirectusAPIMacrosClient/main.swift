import DirectusAPIMacros
import SwiftUI

class Test1 {}
class Test2 {}
class DirectusData {}
protocol DirectusCollection {}

@DirectusClassRegistration(endpointName: "users", endpointPrefix: "/")
final class TestClass: DirectusData, DirectusCollection {
    var name: String
    var icon: String
    var description: String?
    let policies: [String]
    var parent: [String: Data]
    var children: [String]
    var users: [String]
}

@DirectusAddToCollectionList(Test1.self)
struct TestView: View {
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Text("Hello, World!")
                Text("Another Test View")
            }
        }
    }
}
