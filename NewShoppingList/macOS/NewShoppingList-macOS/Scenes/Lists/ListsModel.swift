enum Lists {
    enum Add {
        struct Request {
            let listName: String
        }

        struct Resposne {

        }

        struct ViewModel {

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

    struct Fetch {
        struct Request {

        }

        struct Response {
            let lists: [ShoppingList]
        }

        struct ViewModel {
            let lists: [ShoppingList]
        }
    }
}
