import Foundation

protocol ItemsDisplayLogic: AnyObject {
    func add(viewModel: Items.Add.ViewModel)
    func delete(viewModel: Items.Delete.ViewModel)
    func fetch(viewModel: Items.Fetch.ViewModel)
}

extension ItemsView {
    final class Controller: ObservableObject, ItemsDisplayLogic {
        var interactor: ItemsBusinessLogic?

        @Published
        private(set) var items: [ShoppingItem]

        private var list: ShoppingList {
            didSet {
                items = list.items.sorted {
                    $0.name < $1.name
                }
            }
        }

        init(list: ShoppingList) {
            self.list = list
            self.items = list.items
        }

        func add(_ itemName: String) {
            let request = Items.Add.Request(listId: list.id, itemName: itemName)
            interactor?.add(request: request)
        }

        func add(viewModel: Items.Add.ViewModel) {
            list = viewModel.list
        }

        func delete(_ item: ShoppingItem) {
            let request = Items.Delete.Request(listId: list.id, itemId: item.id)
            interactor?.delete(request: request)
        }

        func delete(viewModel: Items.Delete.ViewModel) {
            list = viewModel.list
        }

        func fetch() {
            let request = Items.Fetch.Request(listId: list.id)
            interactor?.fetch(request: request)
        }

        func fetch(viewModel: Items.Fetch.ViewModel) {
            list = viewModel.list
        }
    }
}
