protocol MainRepository {
    func allLists() -> [ShoppingList]
    func list(withId listId: Id<ShoppingList>) -> ShoppingList?
    func addList(withName listName: String)
    func deleteList(withId listId: Id<ShoppingList>)

    func addItem(withName itemName: String, toListWithId listId: Id<ShoppingList>)
    func deleteItem(withId itemId: Id<ShoppingItem>)
    func updateItem(_ item: ShoppingItem)
}
