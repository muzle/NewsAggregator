import Foundation
import RealmSwift

enum RealmConfigurationFactory {
    static func makePostsConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration(
            readOnly: false,
            schemaVersion: 1,
            migrationBlock: .none,
            deleteRealmIfMigrationNeeded: false,
            objectTypes: [
                RMPost.self
            ]
        )
        guard let url = config.fileURL else {
            preconditionFailure("Realm FileUrl cannot be empty")
        }
        config.fileURL = url.deletingLastPathComponent().appendingPathComponent("FavoritePosts.realm")
        return config
    }
}
