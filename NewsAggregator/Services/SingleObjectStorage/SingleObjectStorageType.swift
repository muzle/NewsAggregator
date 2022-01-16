import Foundation
import RxSwift

public protocol SingleObjectStorageType: ReactiveCompatible {
    associatedtype DataType
    func data() throws -> DataType?
    @discardableResult
    func update(data: DataType) throws -> DataType
    func updateDate() throws -> Date?
    func clear()
    func addDataObserver(completion: ((DataType?) -> Void)?)
}
