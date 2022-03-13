import CoreData
import CloudKit

final class CoreDataMainRepository: NSObject, MainRepository {
    private let container: NSPersistentCloudKitContainer
    private let context: NSManagedObjectContext
    private let listController: NSFetchedResultsController<ShoppingListEntity>

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

        listController = NSFetchedResultsController(
            fetchRequest: ShoppingListEntity.fetchAllRequest(),
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

        super.init()

        listController.delegate = self
    }

    func allLists() -> [ShoppingList] {
        try? listController.performFetch()

        let entities = listController
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

    func addItem(withName itemName: String, toListWithId listId: Id<ShoppingList>) {
        let request: NSFetchRequest<ShoppingListEntity> = ShoppingListEntity.fetchRequest()
        request.predicate = .init(format: "id == %@", listId.toUuid() as CVarArg)

        guard let listEntities = try? context.fetch(request) else {
            assertionFailure("Unable to execute request.")
            return
        }

        guard let listEntity = listEntities.first else {
            assertionFailure("Unable to find entity.")
            return
        }

        let item = ShoppingItem.Factory.new(withName: itemName)
        let itemEntity = ShoppingItemEntity.fromShoppingItem(item, listEntity, context: context)

        context.insert(itemEntity)
        context.saveChanges()
    }

    func deleteItem(withId itemId: Id<ShoppingItem>) {
        let request: NSFetchRequest<ShoppingItemEntity> = ShoppingItemEntity.fetchRequest()
        request.predicate = .init(format: "id == %@", itemId.toUuid() as CVarArg)

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
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        guard let listEntity = anObject as? ShoppingListEntity else {
            return
        }

        let notificationName = Notification.Name(rawValue: "ShoppingListEntityHaveChanged")
        NotificationCenter.default.post(name: notificationName, object: listEntity.toShoppingList())
    }
}
