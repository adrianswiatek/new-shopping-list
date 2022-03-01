import Foundation

struct ShoppingList: Identifiable {
    let id: Id<ShoppingList>
    let name: String
    let numberOfItems: Int

    private init(_ id: Id<ShoppingList>, _ name: String, _ numberOfItems: Int) {
        self.id = id
        self.name = name
        self.numberOfItems = numberOfItems
    }
}

extension ShoppingList {
    final class Factory {
        static func new(withName name: String) -> ShoppingList {
            ShoppingList(.new(), name, 0)
        }

        static func fromRaw(id: UUID, name: String, numberOfItems: Int) -> ShoppingList {
            ShoppingList(.fromUUid(id), name, numberOfItems)
        }
    }
}

extension ShoppingList: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
