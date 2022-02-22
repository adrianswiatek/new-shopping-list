import CoreData
import CloudKit

final class CoreDataMainRepository: NSObject, MainRepository {
    private let container: NSPersistentCloudKitContainer
    private let context: NSManagedObjectContext
    private let controller: NSFetchedResultsController<ShoppingListEntity>

    override init() {
        container = NSPersistentCloudKitContainer(name: "Main")
        container.loadPersistentStores { _, error in
            if let error = error {
                let errorMessage = error.localizedDescription
                fatalError("Unable to load underlying data store. Error: " + errorMessage)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        context = container.viewContext

        controller = NSFetchedResultsController(
            fetchRequest: ShoppingListEntity.fetchAllRequest(),
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

        super.init()

        controller.delegate = self
    }

    func allLists() -> [ShoppingList] {
        try? controller.performFetch()

        let entities = controller
            .fetchedObjects?
            .map { $0.toShoppingList() }

        return entities ?? []
    }

    func list(withId listId: Id<ShoppingList>) -> ShoppingList? {
        let request: NSFetchRequest<ShoppingListEntity> = ShoppingListEntity.fetchRequest()
        request.predicate = .init(format: "id == %@", listId.toUuid() as CVarArg)

        let entities = try? context.fetch(request)
        let lists = entities?.map { $0.toShoppingList() }

        guard lists?.count == 1 else {
            return nil
        }

        return lists?.first
    }

    func addList(withName listName: String) {
        let list: ShoppingList = .Factory.new(withName: listName)
        let entity: ShoppingListEntity = .fromShoppingList(list, context: context)

        context.insert(entity)
        context.saveChanges()
    }

    func deleteList(withId listId: Id<ShoppingList>) {
        let request: NSFetchRequest<ShoppingListEntity> = ShoppingListEntity.fetchRequest()
        request.predicate = .init(format: "id == %@", listId.toUuid() as CVarArg)

        guard let entities = try? context.fetch(request) else {
            assertionFailure("Unable to execute request.")
            return
        }

        guard let entity = entities.first else {
            assertionFailure("Unable to find entity to delete.")
            return
        }

        context.delete(entity)
        context.saveChanges()
    }
}

extension CoreDataMainRepository: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        guard controller.fetchedObjects is [ShoppingListEntity] else {
            return
        }

        let notificationName = Notification.Name(rawValue: "ModelChangedFromRemote")
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}
