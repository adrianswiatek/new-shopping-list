import Combine
import Foundation

protocol ItemsDisplayLogic: AnyObject {
    func delete(viewModel: Items.Delete.ViewModel)
    func fetch(viewModel: Items.Fetch.ViewModel)
    func update(viewModel: Items.Update.ViewModel)
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

        func delete(indexSet: IndexSet) {
            let item = indexSet.first.map { itemsToBuy[$0] }
            guard let item = item else {
                 return
            }
            let request = Items.Delete.Request(item: item)
            interactor?.delete(request: request)
        }

        func delete(viewModel: Items.Delete.ViewModel) {

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

        func update(viewModel: Items.Update.ViewModel) {

        }
    }
}
