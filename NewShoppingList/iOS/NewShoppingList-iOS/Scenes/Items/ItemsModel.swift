enum Items {
    enum Delete {
        struct Request {
            let item: ShoppingItem
        }

        struct Response {

        }

        struct ViewModel {
            
        }
    }

    enum Fetch {
        struct Request {

        }

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

        struct Response {

        }

        struct ViewModel {

        }
    }
}
