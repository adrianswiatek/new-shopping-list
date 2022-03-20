import Combine

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
        var listName: String

        @Published
        var basketIcon: String

        init(listName: String) {
            self.itemsToBuy = []
            self.itemsInBasket = []
            self.listName = listName
            self.basketIcon = ""
        }

        func fetch() {
            let request = Items.Fetch.Request()
            interactor?.fetch(request: request)
        }

        func fetch(viewModel: Items.Fetch.ViewModel) {
            listName = viewModel.listName
            basketIcon = determineBasketIcon(hasItemsInBasket: viewModel.hasItemsInBasket)
            itemsToBuy = viewModel.itemsToBuy
            itemsInBasket = viewModel.itemsInBasket
        }

        private func determineBasketIcon(hasItemsInBasket: Bool) -> String {
            hasItemsInBasket ? "cart.fill" : "cart"
        }
    }
}
