enum Lists {
    enum Delete {
        struct Request {
            let listId: Id<ShoppingList>
        }

        struct Response {

        }

        struct ViewModel {

        }
    }

    enum Fetch {
        struct Request {
            enum Variant {
                case all
                case single(listId: Id<ShoppingList>)
            }

            let variant: Variant
        }

        struct Response {
            let lists: [ShoppingList]
        }

        struct ViewModel {
            let lists: [ShoppingList]
        }
    }
}
