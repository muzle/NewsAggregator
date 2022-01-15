import Foundation
import CoreData

private struct Constants {
    let mombName = "Model"
}
private let constants = Constants()

final class DBLoader {
    private let storeCoordinator: NSPersistentStoreCoordinator
    let context: NSManagedObjectContext

    public init() {
        let bundle = Bundle(for: DBLoader.self)
        guard
            let url = bundle.url(forResource: constants.mombName, withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: url)
        else {
            preconditionFailure("Unable create dateBase Model")
        }
        storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.storeCoordinator
        migrateStore()
    }
    
    private func migrateStore() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError()
        }
        let storeUrl = url.appendingPathComponent("Model.sqlite")
        do {
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                    configurationName: nil,
                    at: storeUrl,
                    options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
}
