enum Home {
    enum AddList {
        struct Request {
            let listName: String
        }

        struct Resposne {
            let lists: [ShoppingList]
        }

        struct ViewModel {
            let lists: [ShoppingList]
        }
    }

    enum DeleteList {
        struct Request {
            let listId: Id<ShoppingList>
        }

        struct Response {
            let lists: [ShoppingList]
        }

        struct ViewModel {
            var lists: [ShoppingList]
        }
    }
}
