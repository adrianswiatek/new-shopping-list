import Foundation
import CoreData

@objc(ShoppingItemEntity)
class ShoppingItemEntity: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var state: Int
    @NSManaged var shoppingList: ShoppingListEntity

    @nonobjc
    class func fetchRequest() -> NSFetchRequest<ShoppingItemEntity> {
        NSFetchRequest<ShoppingItemEntity>(entityName: "ShoppingItemEntity")
    }
}

extension ShoppingItemEntity {
    func toShoppingItem() -> ShoppingItem {
        ShoppingItem.Factory.new(
            id: .fromUUid(id),
            name: name,
            state: .fromInt(state)
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
        entity.state = shoppingItem.state.toInt()
        entity.shoppingList = shoppingListEntity
        return entity
    }
}

extension ShoppingItem.State {
    private static var stateToIntMapping: [Int: Self] {
        [1: .toBuy, 2: inBasket]
    }

    static func fromInt(_ int: Int) -> ShoppingItem.State {
        guard let state = stateToIntMapping[int] else {
            preconditionFailure("Found unexpected value: \(int).")
        }
        return state
    }

    func toInt() -> Int {
        let int = Self.stateToIntMapping
            .first { $0.value == self }
            .map { $0.key }

        guard let int = int else {
            preconditionFailure("Unable to found a value for given case \(self).")
        }

        return int
    }
}
