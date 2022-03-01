import Foundation
import CoreData

@objc(ItemEntity)
class ItemEntity: NSManagedObject, Identifiable {
    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var shoppingList: ShoppingListEntity?

    @nonobjc
    static func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }
}
