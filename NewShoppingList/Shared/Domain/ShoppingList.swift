import Foundation

struct ShoppingList: Identifiable {
    let id: Id<ShoppingList>
    let name: String
    let items: [ShoppingItem]

    var numberOfItems: Int {
        items.count
    }

    var itemsToBuy: [ShoppingItem] {
        items.filter { $0.state == .toBuy }
    }

    var itemsInBasket: [ShoppingItem] {
        items.filter { $0.state == .inBasket }
    }

    private init(_ id: Id<ShoppingList>, _ name: String, _ items: [ShoppingItem]) {
        self.id = id
        self.name = name
        self.items = items.sorted { $0.name < $1.name }
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
