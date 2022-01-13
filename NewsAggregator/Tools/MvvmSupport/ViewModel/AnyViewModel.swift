import Foundation

final class AnyViewModel<Input, Output>: ViewModelType {
    private let transformation: (Input) -> Output
    
    init<Model: ViewModelType>(_ model: Model) where Model.Input == Input, Model.Output == Output {
        transformation = model.transform(input:)
    }
    
    func transform(input: Input) -> Output {
        transformation(input)
    }
}
