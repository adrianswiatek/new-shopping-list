import Foundation

struct ShoppingItem: Identifiable {
    let id: Id<ShoppingItem>
    let name: String
    let details: String
    let state: State

    var hasDetails: Bool {
        details.isEmpty == false
    }

    func withName(_ name: String) -> ShoppingItem {
        ShoppingItem(id, name, details, state)
    }

    func withDetails(_ details: String) -> ShoppingItem {
        ShoppingItem(id, name, details, state)
    }

    func withState(_ state: State) -> ShoppingItem {
        ShoppingItem(id, name, details, state)
    }

    private init(_ id: Id<ShoppingItem>, _ name: String, _ details: String, _ state: State) {
        self.id = id
        self.name = name
        self.details = details
        self.state = state
    }
}

extension ShoppingItem {
    final class Factory {
        static func new(withName name: String) -> ShoppingItem {
            ShoppingItem(.new(), name, "", .toBuy)
        }

        static func new(id: Id<ShoppingItem>, name: String, details: String, state: State) -> ShoppingItem {
            ShoppingItem(id, name, details, state)
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
