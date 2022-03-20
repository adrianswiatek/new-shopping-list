import Foundation

struct ShoppingItem: Identifiable {
    let id: Id<ShoppingItem>
    let name: String
    let state: State

    func withName(_ name: String) -> ShoppingItem {
        ShoppingItem(id, name, state)
    }

    func withState(_ state: State) -> ShoppingItem {
        ShoppingItem(id, name, state)
    }

    private init(_ id: Id<ShoppingItem>, _ name: String, _ state: State) {
        self.id = id
        self.name = name
        self.state = state
    }
}

extension ShoppingItem {
    final class Factory {
        static func new(withName name: String) -> ShoppingItem {
            ShoppingItem(.new(), name, .toBuy)
        }

        static func new(id: Id<ShoppingItem>, name: String, state: State) -> ShoppingItem {
            ShoppingItem(id, name, state)
        }
    }

    enum State {
        case toBuy
        case inBasket
    }
}

extension ShoppingItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
