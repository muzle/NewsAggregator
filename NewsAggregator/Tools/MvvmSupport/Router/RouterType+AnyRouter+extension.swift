import Foundation

extension RouterType {
    func asRouter() -> AnyRouter<Event> {
        AnyRouter<Event>(self)
    }
}
