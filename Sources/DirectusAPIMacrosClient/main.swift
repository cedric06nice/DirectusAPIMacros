import DirectusAPIMacros

protocol Test1 {}
protocol Test2 {}
protocol DirectusCollection {}

@DirectusClassRegistration
@DirectusAddToCollectionList(Test1.self, Test2.self, Test1.self)
class TestClass: DirectusCollection {
    var string = "Test"
}
