import CoreData
import CloudKit

final class CoreDataHomeRepository: NSObject, HomeRepository {
    private var lists: [ShoppingList] = []

    private let container: NSPersistentCloudKitContainer
    private let context: NSManagedObjectContext
    private let controller: NSFetchedResultsController<ShoppingListEntity>

    override init() {
        container = NSPersistentCloudKitContainer(name: "Main-macOS")
        container.loadPersistentStores { _, error in
            if let error = error {
                let errorMessage = error.localizedDescription
                fatalError("Unable to load underlying data store. Error: " + errorMessage)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        context = container.viewContext

        let fetchRequest = ShoppingListEntity.fetchRequest()
        fetchRequest.sortDescriptors = [.init(key: "name", ascending: true)]

        controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
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

extension CoreDataHomeRepository: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        guard controller.fetchedObjects is [ShoppingListEntity] else {
            return
        }

        let notificationName = Notification.Name(rawValue: "HomeModelChangedFromRemote")
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}
