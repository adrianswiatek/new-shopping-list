protocol HomeRepository {
    func allLists() -> [ShoppingList]
    func addList(withName listName: String)
    func deleteList(withId listId: Id<ShoppingList>)
}
