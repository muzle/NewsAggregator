import Foundation

protocol ViewModelType {
    associatedtype Unit: UnitType = SimpleUnit<Input, Output, Never> where Unit.Input == Input, Unit.Output == Output
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
