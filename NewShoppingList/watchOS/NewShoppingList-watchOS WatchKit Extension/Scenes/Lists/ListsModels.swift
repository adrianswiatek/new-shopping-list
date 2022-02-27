enum Lists {
    enum Fetch {
        struct Request {

        }

        struct Response {
            let lists: [ShoppingList]
        }

        struct ViewModel {
            let lists: [ShoppingList]
        }
    }

    enum Delete {
        struct Request {
            let listId: Id<ShoppingList>
        }

        struct Response {

        }

        struct ViewModel {
            
        }
    }
}
