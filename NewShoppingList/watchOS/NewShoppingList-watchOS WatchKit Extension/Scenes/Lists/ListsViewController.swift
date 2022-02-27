import Combine
import Foundation

protocol DisplayLogic: AnyObject {
    func delete(viewModel: Lists.Delete.ViewModel)
    func fetch(viewModel: Lists.Fetch.ViewModel)
}

extension ListsView {
    final class Controller: ObservableObject, DisplayLogic {
        var interactor: ListsBusinessLogic?

        @Published private(set) var lists: [ShoppingList] = []

        func fetch() {
            let request = Lists.Fetch.Request()
            interactor?.fetch(request: request)
        }

        func fetch(viewModel: Lists.Fetch.ViewModel) {
            lists = viewModel.lists
        }

        func delete(_ indexSet: IndexSet) {
            guard let index = indexSet.first else {
                return
            }

            let request = Lists.Delete.Request(listId: lists[index].id)
            interactor?.delete(request: request)
        }

        func delete(viewModel: Lists.Delete.ViewModel) {

        }
    }
}
