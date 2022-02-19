import Foundation

struct ShoppingList: Identifiable {
    let id: Id<ShoppingList>
    let name: String

    private init(_ id: Id<ShoppingList>, _ name: String) {
        self.id = id
        self.name = name
    }
}

extension ShoppingList {
    final class Factory {
        static func new(withName listName: String) -> ShoppingList {
            ShoppingList(.new(), listName)
        }
    }
}

extension ShoppingList: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
