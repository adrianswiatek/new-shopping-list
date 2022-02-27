protocol MainRepository {
    func allLists() -> [ShoppingList]
    func list(withId listId: Id<ShoppingList>) -> ShoppingList?
    func addList(withName listName: String)
    func deleteList(withId listId: Id<ShoppingList>)
}
