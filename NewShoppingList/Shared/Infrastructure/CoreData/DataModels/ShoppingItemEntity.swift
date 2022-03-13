import Foundation
import CoreData

@objc(ShoppingItemEntity)
class ShoppingItemEntity: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var shoppingList: ShoppingListEntity

    @nonobjc
    class func fetchRequest() -> NSFetchRequest<ShoppingItemEntity> {
        NSFetchRequest<ShoppingItemEntity>(entityName: "ShoppingItemEntity")
    }

    @nonobjc
    static func fetchAllRequest() -> NSFetchRequest<ShoppingItemEntity> {
        let fetchRequest = ShoppingItemEntity.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \ShoppingItemEntity.name, ascending: true)
        ]
        return fetchRequest
    }
}

extension ShoppingItemEntity {
    func toShoppingItem() -> ShoppingItem {
        ShoppingItem.Factory.fromRaw(
            id: id,
            name: name
        )
    }

    static func fromShoppingItem(
        _ shoppingItem: ShoppingItem,
        _ shoppingListEntity: ShoppingListEntity,
        context: NSManagedObjectContext
    ) -> ShoppingItemEntity {
        let entity = ShoppingItemEntity(context: context)
        entity.id = shoppingItem.id.toUuid()
        entity.name = shoppingItem.name
        entity.shoppingList = shoppingListEntity
        return entity
    }
}
