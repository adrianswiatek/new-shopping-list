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

    enum MoveToBasket {
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

    enum RemoveFromBasket {
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
}
