import Foundation
import CoreData

@objc(ShoppingListEntity)
class ShoppingListEntity: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String

    @nonobjc
    static func fetchRequest() -> NSFetchRequest<ShoppingListEntity> {
        NSFetchRequest<ShoppingListEntity>(entityName: "ShoppingListEntity")
    }

    static func fetchAllRequest() -> NSFetchRequest<ShoppingListEntity> {
        let fetchRequest = ShoppingListEntity.fetchRequest()
        fetchRequest.sortDescriptors = []
        return fetchRequest
    }
}

extension ShoppingListEntity {
    func toShoppingList() -> ShoppingList {
        ShoppingList.Factory.fromRaw(id: id, name: name)
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
