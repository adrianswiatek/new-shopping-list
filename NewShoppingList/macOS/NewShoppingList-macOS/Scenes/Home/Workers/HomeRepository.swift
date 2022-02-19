import Combine
import CoreData

protocol HomeRepository {
    func allLists() -> [ShoppingList]
    func addList(withName listName: String)
    func deleteList(withId listId: Id<ShoppingList>)
}

final class CoreDataHomeRepository: HomeRepository {
    private var lists: [ShoppingList] = []

    func allLists() -> [ShoppingList] {
        lists
    }

    func addList(withName listName: String) {
        let shoppingList = ShoppingList.Factory.new(withName: listName)
        lists.append(shoppingList)
    }

    func deleteList(withId listId: Id<ShoppingList>) {
        lists.removeAll { $0.id == listId }
    }
}
