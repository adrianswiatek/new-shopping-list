enum Items {
    enum Add {
        struct Request {
            let name: String
        }
    }

    enum Delete {
        struct Request {
            let item: ShoppingItem
        }
    }

    enum Fetch {
        struct Request {}

        struct Response {
            let list: ShoppingList
        }

        struct ViewModel {
            let listName: String
            let itemsToBuy: [ShoppingItem]
            let itemsInBasket: [ShoppingItem]
        }
    }

    enum Update {
        struct Request {
            let item: ShoppingItem
        }
    }
}
