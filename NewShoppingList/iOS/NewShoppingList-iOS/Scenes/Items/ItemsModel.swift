enum Items {
    enum Fetch {
        struct Request {

        }

        struct Response {
            let list: ShoppingList
        }

        struct ViewModel {
            let listName: String
            let hasItemsInBasket: Bool
            let itemsToBuy: [ShoppingItem]
            let itemsInBasket: [ShoppingItem]
        }
    }
}
