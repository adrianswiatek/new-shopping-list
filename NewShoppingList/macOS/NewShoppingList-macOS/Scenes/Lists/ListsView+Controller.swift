import Combine
import Foundation

protocol ListsDisplayLogic: AnyObject {
    func addList(viewModel: Lists.Add.ViewModel)
    func deleteList(viewModel: Lists.Delete.ViewModel)
    func fetchLists(viewModel: Lists.Fetch.ViewModel)
}

extension ListsView {
    final class Controller: ObservableObject, ListsDisplayLogic {
        var interactor: ListsInteractor?

        @Published
        private(set) var lists: [ShoppingList] = []

        func addList(withName listName: String) {
            let request = Lists.Add.Request(listName: listName)
            interactor?.addList(request: request)
        }

        func addList(viewModel: Lists.Add.ViewModel) {

        }

        func deleteList(withId listId: Id<ShoppingList>?) {
            guard let listId = listId else {
                return
            }

            let request = Lists.Delete.Request(listId: listId)
            interactor?.deleteList(request: request)
        }

        func deleteList(viewModel: Lists.Delete.ViewModel) {

        }

        func fetchLists() {
            let request = Lists.Fetch.Request()
            interactor?.fetchLists(request: request)
        }

        func fetchLists(viewModel: Lists.Fetch.ViewModel) {
            lists = viewModel.lists
        }
    }
}
