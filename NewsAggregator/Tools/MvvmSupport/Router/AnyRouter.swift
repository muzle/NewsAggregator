import Foundation

final class AnyRouter<Event>: RouterType {
    private let completion: (Event) -> Void
    
    init(_ completion: @escaping (Event) -> Void) {
        self.completion = completion
    }
    
    init<Router: RouterType>(_ router: Router) where Router.Event == Event {
        completion = router.handle(event:)
    }
    
    func handle(event: Event) {
        completion(event)
    }
}
