protocol MainRepository {
    func allLists() -> [ShoppingList]
    func list(withId listId: Id<ShoppingList>) -> ShoppingList?
    func addList(withName listName: String)
    func deleteList(withId listId: Id<ShoppingList>)

    func addItem(withName itemName: String, toListWithId listId: Id<ShoppingList>)
    func changeStateOfItem(withId itemId: Id<ShoppingItem>, to state: ShoppingItem.State)
    func deleteItem(withId itemId: Id<ShoppingItem>)
}
