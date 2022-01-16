import Foundation

final class UserDefaultsSingleObjectStorage<T: Codable>: SingleObjectStorage<T> {
    typealias Closure = (T?) -> Void
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let storage: UserDefaults
    private let key: String
    private let notificationCenter: NotificationCenter
    private var closures = [Closure?]()
    
    init(
        key: String,
        decoder: JSONDecoder = JSONDecoderFactory.common,
        encoder: JSONEncoder = JSONEncoderFactory.common,
        storage: UserDefaults = .standard,
        notificationCenter: NotificationCenter = .default
    ) {
        self.key = key
        self.decoder = decoder
        self.encoder = encoder
        self.storage = storage
        self.notificationCenter = notificationCenter
        super.init()
        
        notificationCenter.addObserver(
            self,
            selector: #selector(objectDidChange(_:)),
            name: .init(key),
            object: nil
        )
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    struct Container: Codable {
        let data: T
        let date: Date
    }
    
    private func getContainer() throws -> Container? {
        guard let data = storage.value(forKey: key) as? Data else { return nil }
        return try decoder.decode(Container.self, from: data)
    }
    
    override func data() throws -> T? {
        try getContainer()?.data
    }
    
    override func updateDate() throws -> Date? {
        try getContainer()?.date
    }
    
    @discardableResult
    override func update(data: T) throws -> T {
        let container = Container(data: data, date: .init())
        let data_ = try encoder.encode(container)
        storage.setValue(data_, forKey: key)
        post(data)
        return data
    }
    
    override func clear() {
        storage.removeObject(forKey: key)
        post(nil)
    }
    
    override func addDataObserver(completion: ((T?) -> Void)?) {
        do {
            let data = try data()
            completion?(data)
        } catch {
            print(error.localizedDescription)
        }
        closures.append(completion)
    }
    
    private func post(_ object: T?) {
        notificationCenter.post(name: .init(key), object: object)
    }
    
    @objc
    private func objectDidChange(_ notification: Notification) {
        guard let object = notification.object as? T? else { return }
        closures.forEach { $0?(object) }
    }
}
