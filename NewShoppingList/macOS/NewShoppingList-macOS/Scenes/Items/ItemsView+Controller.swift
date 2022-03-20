import Foundation

protocol ItemsDisplayLogic: AnyObject {
    func add(viewModel: Items.Add.ViewModel)
    func delete(viewModel: Items.Delete.ViewModel)
    func fetch(viewModel: Items.Fetch.ViewModel)
    func update(viewModel: Items.Update.ViewModel)
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
                itemsToBuy = list.items(.toBuy)
                itemsInBasket = list.items(.inBasket)
            }
        }

        init(list: ShoppingList) {
            self.list = list
            self.itemsToBuy = list.items(.toBuy)
            self.itemsInBasket = list.items(.inBasket)
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
            let request = Items.Update.Request(listId: list.id, item: item.withState(.inBasket))
            interactor?.update(request: request)
        }

        func removeFromBasket(_ item: ShoppingItem) {
            let request = Items.Update.Request(listId: list.id, item: item.withState(.toBuy))
            interactor?.update(request: request)
        }

        func update(itemName: String, inItem item: ShoppingItem) {
            let request = Items.Update.Request(listId: list.id, item: item.withName(itemName))
            interactor?.update(request: request)
        }

        func update(viewModel: Items.Update.ViewModel) {
            list = viewModel.list
        }
    }
}
