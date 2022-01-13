import Foundation

protocol RouterType {
    associatedtype Event
    func handle(event: Event)
}
