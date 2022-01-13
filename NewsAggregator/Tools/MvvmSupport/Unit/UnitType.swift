import Foundation

protocol UnitType {
    associatedtype Event = Never
    associatedtype Input
    associatedtype Output
}

extension UnitType {
    typealias ViewModel = AnyViewModel<Input, Output>
    typealias Router = AnyRouter<Event>
}
