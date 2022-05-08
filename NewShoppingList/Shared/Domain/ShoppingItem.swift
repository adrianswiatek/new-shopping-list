import Foundation

struct ShoppingItem: Identifiable {
    let id: Id<ShoppingItem>
    let name: String
    let details: String
    let category: String
    let state: State

    var hasDetails: Bool {
        details.isEmpty == false
    }
    
    var hasCategory: Bool {
        category.isEmpty == false
    }

    func withName(_ name: String) -> ShoppingItem {
        ShoppingItem(id, name, details, category, state)
    }

    func withDetails(_ details: String) -> ShoppingItem {
        ShoppingItem(id, name, details, category, state)
    }
    
    func withCategory(_ category: String) -> ShoppingItem {
        ShoppingItem(id, name, details, category, state)
    }

    func withState(_ state: State) -> ShoppingItem {
        ShoppingItem(id, name, details, category, state)
    }

    private init(
        _ id: Id<ShoppingItem>,
        _ name: String,
        _ details: String,
        _ category: String,
        _ state: State
    ) {
        self.id = id
        self.name = name
        self.details = details
        self.category = category
        self.state = state
    }
}

extension ShoppingItem {
    final class Factory {
        static func new(withName name: String) -> ShoppingItem {
            ShoppingItem(.new(), name, "", "", .toBuy)
        }

        static func new(
            id: Id<ShoppingItem>,
            name: String,
            details: String,
            category: String,
            state: State
        ) -> ShoppingItem {
            ShoppingItem(id, name, details, category, state)
        }
    }

    enum State {
        case toBuy
        case inBasket
    }
    
    enum Categorization: Hashable {
        case categorized(categoryName: String)
        case uncategorized
        
        var categoryName: String? {
            switch self {
            case .categorized(let categoryName):
                return categoryName
            case .uncategorized:
                return nil
            }
        }
    }
}

extension ShoppingItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
