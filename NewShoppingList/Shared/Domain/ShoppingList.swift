import Foundation

struct ShoppingList: Identifiable {
    let id: Id<ShoppingList>
    let name: String

    private let items: [ShoppingItem]

    private init(_ id: Id<ShoppingList>, _ name: String, _ items: [ShoppingItem]) {
        self.id = id
        self.name = name
        self.items = items.sorted { $0.name < $1.name }
    }

    func items(_ state: ShoppingItem.State? = nil) -> [ShoppingItem] {
        switch state {
        case .toBuy:
            return items.filter { $0.state == .toBuy }
        case .inBasket:
            return items.filter { $0.state == .inBasket }
        default:
            return items
        }
    }

    func numberOfItems(_ state: ShoppingItem.State? = nil) -> Int {
        items(state).count
    }

    func hasItems(_ state: ShoppingItem.State? = nil) -> Bool {
        !items(state).isEmpty
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
