import Combine
import Foundation

protocol HomeDisplayLogic: AnyObject {
    func addList(viewModel: Home.AddList.ViewModel)
    func deleteList(viewModel: Home.DeleteList.ViewModel)
}

extension HomeView {
    final class Controller: ObservableObject, HomeDisplayLogic {
        var interactor: HomeInteractor?

        @Published
        private(set) var lists: [ShoppingList] = []

        func addList(withName listName: String) {
            let request = Home.AddList.Request(listName: listName)
            interactor?.addList(request: request)
        }

        func addList(viewModel: Home.AddList.ViewModel) {
            lists = viewModel.lists
        }

        func deleteList(_ list: ShoppingList?) {
            guard let listId = list?.id else { return }

            let request = Home.DeleteList.Request(listId: listId)
            interactor?.deleteList(request: request)
        }

        func deleteList(viewModel: Home.DeleteList.ViewModel) {
            lists = viewModel.lists
        }
    }
}
