import Foundation

protocol ItemsDisplayLogic: AnyObject {
    func add(viewModel: Items.Add.ViewModel)
    func delete(viewModel: Items.Delete.ViewModel)
    func fetch(viewModel: Items.Fetch.ViewModel)
    func moveToBasket(viewModel: Items.MoveToBasket.ViewModel)
}

extension ItemsView {
    final class Controller: ObservableObject, ItemsDisplayLogic {
        var interactor: ItemsBusinessLogic?

        @Published
        private(set) var itemsToBuy: [ShoppingItem]

        @Published
        private(set) var itemsInBasket: [ShoppingItem]

        private var list: ShoppingList {
            didSet {
                itemsToBuy = list.itemsToBuy
                itemsInBasket = list.itemsInBasket
            }
        }

        init(list: ShoppingList) {
            self.list = list
            self.itemsToBuy = list.itemsToBuy
            self.itemsInBasket = list.itemsInBasket
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

        func moveToBasket(_ item: ShoppingItem) {
            let request = Items.MoveToBasket.Request(listId: list.id, itemId: item.id)
            interactor?.moveToBasket(request: request)
        }

        func moveToBasket(viewModel: Items.MoveToBasket.ViewModel) {
            list = viewModel.list
        }
    }
}
