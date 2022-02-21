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
        static func new(withName name: String) -> ShoppingList {
            ShoppingList(.new(), name)
        }

        static func fromRaw(id: UUID, name: String) -> ShoppingList {
            ShoppingList(.fromUUid(id), name)
        }
    }
}

extension ShoppingList: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
