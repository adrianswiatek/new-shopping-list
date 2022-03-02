import Combine
import Foundation

protocol ListsDisplayLogic: AnyObject {
    func addList(viewModel: Lists.AddList.ViewModel)
    func deleteList(viewModel: Lists.DeleteList.ViewModel)
    func fetchLists(viewModel: Lists.FetchLists.ViewModel)
}

extension ListsView {
    final class Controller: ObservableObject, ListsDisplayLogic {
        var interactor: ListsInteractor?

        @Published
        private(set) var lists: [ShoppingList] = []

        func addList(withName listName: String) {
            let request = Lists.AddList.Request(listName: listName)
            interactor?.addList(request: request)
        }

        func addList(viewModel: Lists.AddList.ViewModel) {

        }

        func deleteList(_ list: ShoppingList?) {
            guard let listId = list?.id else { return }

            let request = Lists.DeleteList.Request(listId: listId)
            interactor?.deleteList(request: request)
        }

        func deleteList(viewModel: Lists.DeleteList.ViewModel) {

        }

        func fetchLists() {
            let request = Lists.FetchLists.Request()
            interactor?.fetchLists(request: request)
        }

        func fetchLists(viewModel: Lists.FetchLists.ViewModel) {
            lists = viewModel.lists
        }
    }
}
