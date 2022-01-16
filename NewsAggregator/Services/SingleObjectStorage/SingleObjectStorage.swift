import Foundation

open class SingleObjectStorage<T>: SingleObjectStorageType {
    public typealias DataType = T
    
    public init() {
        
    }
    
    public func data() throws -> T? {
        makeError()
    }
    
    public func update(data: T) throws -> T {
        makeError()
    }
    
    public func updateDate() throws -> Date? {
        makeError()
    }
    
    public func clear() {
        makeError()
    }
    
    public func addDataObserver(completion: ((T?) -> Void)?) {
        makeError()
    }
    
    private func makeError() -> Never {
        preconditionFailure("The abstract class was not implemented")
    }
}
