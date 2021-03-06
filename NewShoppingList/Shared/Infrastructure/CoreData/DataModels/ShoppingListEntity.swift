import Foundation
import CoreData

@objc(ShoppingListEntity)
class ShoppingListEntity: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var shoppingItems: NSSet

    @nonobjc
    static func fetchRequest() -> NSFetchRequest<ShoppingListEntity> {
        NSFetchRequest<ShoppingListEntity>(entityName: "ShoppingListEntity")
    }

    @nonobjc
    static func fetchAllRequest() -> NSFetchRequest<ShoppingListEntity> {
        let fetchRequest = ShoppingListEntity.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \ShoppingListEntity.name, ascending: true)
        ]
        return fetchRequest
    }
}

extension ShoppingListEntity {
    func toShoppingList() -> ShoppingList {
        ShoppingList.Factory.fromRaw(
            id: id,
            name: name,
            items: shoppingItems
                .map { $0 as? ShoppingItemEntity }
                .compactMap { $0?.toShoppingItem() }
        )
    }

    static func fromShoppingList(
        _ shoppingList: ShoppingList,
        context: NSManagedObjectContext
    ) -> ShoppingListEntity {
        let entity = ShoppingListEntity(context: context)
        entity.id = shoppingList.id.toUuid()
        entity.name = shoppingList.name
        return entity
    }
}

extension ShoppingListEntity {
    @objc(addItemsObject:)
    @NSManaged func addToItems(_ value: ShoppingItemEntity)

    @objc(removeItemsObject:)
    @NSManaged func removeFromItems(_ value: ShoppingItemEntity)

    @objc(addItems:)
    @NSManaged func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged func removeFromItems(_ values: NSSet)
}
