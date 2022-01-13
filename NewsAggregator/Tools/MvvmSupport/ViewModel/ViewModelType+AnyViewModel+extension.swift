import Foundation

extension ViewModelType {
    func asAnyViewModel() -> AnyViewModel<Input, Output> {
        AnyViewModel<Input, Output>(self)
    }
}
