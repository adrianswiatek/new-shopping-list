enum Home {
    enum AddList {
        struct Request {
            let listName: String
        }

        struct Resposne {

        }

        struct ViewModel {

        }
    }

    enum DeleteList {
        struct Request {
            let listId: Id<ShoppingList>
        }

        struct Response {

        }

        struct ViewModel {

        }
    }

    struct FetchLists {
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
