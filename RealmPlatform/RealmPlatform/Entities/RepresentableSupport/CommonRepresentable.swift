import Foundation

internal protocol CommonRepresentable {
    associatedtype CommonType
    
    func asCommon() -> CommonType
}
