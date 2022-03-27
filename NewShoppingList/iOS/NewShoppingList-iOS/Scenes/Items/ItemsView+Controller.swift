import Combine
import Foundation

protocol ItemsDisplayLogic: AnyObject {
    func fetch(viewModel: Items.Fetch.ViewModel)
}

extension ItemsView {
    final class Controller: ObservableObject, ItemsDisplayLogic {
        var interactor: ItemsInteractor?

        @Published
        private(set) var itemsToBuy: [ShoppingItem]

        @Published
        private(set) var itemsInBasket: [ShoppingItem]

        @Published
        private(set) var listName: String

        @Published
        private(set) var basketIcon: String

        var numberOfItemsToBuy: Int {
            itemsToBuy.count
        }

        var numberOfItemsInBasket: Int {
            itemsInBasket.count
        }

        var hasItemsToBuy: Bool {
            !itemsToBuy.isEmpty
        }

        var hasItemsInBasket: Bool {
            !itemsInBasket.isEmpty
        }

        init(initialListName: String) {
            self.itemsToBuy = []
            self.itemsInBasket = []
            self.listName = initialListName
            self.basketIcon = Icon.toBuy
        }

        func addItem(withName itemName: String) {
            let request = Items.Add.Request(name: itemName)
            interactor?.add(request: request)
        }

        func deleteAtIndexSet(_ indexSet: IndexSet) {
            let item = indexSet.first.map { itemsToBuy[$0] }
            guard let item = item else {
                 return
            }
            let request = Items.Delete.Request(item: item)
            interactor?.delete(request: request)
        }

        func deleteItem(_ item: ShoppingItem) {
            let request = Items.Delete.Request(item: item)
            interactor?.delete(request: request)
        }

        func fetch() {
            let request = Items.Fetch.Request()
            interactor?.fetch(request: request)
        }

        func fetch(viewModel: Items.Fetch.ViewModel) {
            listName = viewModel.listName
            itemsToBuy = viewModel.itemsToBuy
            itemsInBasket = viewModel.itemsInBasket
        }

        func moveToBasket(_ item: ShoppingItem) {
            let request = Items.Update.Request(item: item.withState(.inBasket))
            interactor?.update(request: request)
        }

        func removeFromBasket(_ item: ShoppingItem) {
            let request = Items.Update.Request(item: item.withState(.toBuy))
            interactor?.update(request: request)
        }
    }
}
