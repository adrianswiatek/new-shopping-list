import Combine

protocol ListsDisplayLogic: AnyObject {
    func fetch(viewModel: Lists.Fetch.ViewModel)
}

extension ListsView {
    final class Controller: ObservableObject, ListsDisplayLogic {
        var interactor: ListsBusinessLogic?

        @Published
        var lists: [ShoppingList]

        init() {
            self.lists = []
        }

        func fetch() {
            let request = Lists.Fetch.Request(variant: .all)
            interactor?.fetch(request: request)
        }

        func fetch(viewModel: Lists.Fetch.ViewModel) {
            lists = viewModel.lists
        }
    }
}
