import Foundation

struct ShoppingItem: Identifiable {
    let id: Id<ShoppingItem>
    let name: String

    private init(_ id: Id<ShoppingItem>, _ name: String) {
        self.id = id
        self.name = name
    }
}

extension ShoppingItem {
    final class Factory {
        static func new(withName name: String) -> ShoppingItem {
            ShoppingItem(.new(), name)
        }

        static func fromRaw(id: UUID, name: String) -> ShoppingItem {
            ShoppingItem(.fromUUid(id), name)
        }
    }
}

extension ShoppingItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
