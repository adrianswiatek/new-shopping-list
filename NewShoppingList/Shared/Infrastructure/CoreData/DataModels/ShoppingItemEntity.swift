import Foundation
import CoreData

@objc(ShoppingItemEntity)
class ShoppingItemEntity: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var details: String
    @NSManaged var category: CategoryEntity?
    @NSManaged var state: Int
    @NSManaged var shoppingList: ShoppingListEntity

    @nonobjc
    static func fetchRequest() -> NSFetchRequest<ShoppingItemEntity> {
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
        ShoppingItem.Factory.new(
            id: .fromUUid(id),
            name: name,
            details: details,
            category: category?.name ?? "",
            state: .fromInt(state)
        )
    }
    
    static func fromShoppingItem(
        _ shoppingItem: ShoppingItem,
        shoppingListEntity: ShoppingListEntity,
        categoryEntity: CategoryEntity?,
        context: NSManagedObjectContext
    ) -> ShoppingItemEntity {
        let entity = ShoppingItemEntity(context: context)
        entity.id = shoppingItem.id.toUuid()
        entity.name = shoppingItem.name
        entity.details = shoppingItem.details
        entity.state = shoppingItem.state.toInt()
        entity.category = categoryEntity
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
