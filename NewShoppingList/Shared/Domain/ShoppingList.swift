import Foundation

struct ShoppingList: Identifiable {
    let id: Id<ShoppingList>
    let name: String
    let items: [ShoppingItem]

    var numberOfItems: Int {
        items.count
    }

    private init(_ id: Id<ShoppingList>, _ name: String, _ items: [ShoppingItem]) {
        self.id = id
        self.name = name
        self.items = items
    }
}

extension ShoppingList {
    final class Factory {
        static func new(withName name: String) -> ShoppingList {
            ShoppingList(.new(), name, [])
        }

        static func fromRaw(id: UUID, name: String, items: [ShoppingItem]) -> ShoppingList {
            ShoppingList(.fromUUid(id), name, items)
        }
    }
}

extension ShoppingList: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
