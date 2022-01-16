import Foundation

enum UserDefaultsSingleObjectStorageFactory {
    private enum StorageKey {
        static let appSettings = "appSettings"
    }
    
    static func makeAppSettingsStorage() -> SingleObjectStorage<AppSettings> {
        makeStorage(key: StorageKey.appSettings)
    }
    
    private static func makeExtendedKey(for key: String) -> String {
        "UserDefaultsSingleObjectStorageFactory_\(key)"
    }
    private static func makeStorage<T: Codable>(
        key: String,
        storage: UserDefaults = .standard,
        decoder: JSONDecoder = JSONDecoderFactory.common,
        encoder: JSONEncoder = JSONEncoderFactory.common
    ) -> SingleObjectStorage<T> {
        UserDefaultsSingleObjectStorage<T>(
            key: key,
            decoder: decoder,
            encoder: encoder,
            storage: storage,
            notificationCenter: .default
        )
    }
}
