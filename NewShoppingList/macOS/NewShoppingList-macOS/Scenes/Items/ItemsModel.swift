enum Items {
    enum Add {
        struct Request {
            let listId: Id<ShoppingList>
            let itemName: String
        }

        struct Response {
            let list: ShoppingList
        }

        struct ViewModel {
            let list: ShoppingList
        }
    }

    enum Delete {
        struct Request {
            let listId: Id<ShoppingList>
            let itemId: Id<ShoppingItem>
        }

        struct Response {
            let list: ShoppingList
        }

        struct ViewModel {
            let list: ShoppingList
        }
    }

    enum Fetch {
        struct Request {
            let listId: Id<ShoppingList>
        }

        struct Response {
            let list: ShoppingList
        }

        struct ViewModel {
            let list: ShoppingList
        }
    }

    enum Update {
        struct Request {
            let listId: Id<ShoppingList>
            let item: ShoppingItem
        }

        struct Response {
            let list: ShoppingList
        }

        struct ViewModel {
            let list: ShoppingList
        }
    }
}
