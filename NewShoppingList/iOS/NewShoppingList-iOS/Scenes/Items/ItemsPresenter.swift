protocol ItemsPresentationLogic {
    func fetch(response: Items.Fetch.Response)
}

final class ItemsPresenter: ItemsPresentationLogic {
    weak var viewController: ItemsView.Controller?

    func fetch(response: Items.Fetch.Response) {
        let viewModel = Items.Fetch.ViewModel(
            listName: response.list.name,
            hasItemsInBasket: response.list.hasItems(.inBasket),
            itemsToBuy: response.list.items(.toBuy),
            itemsInBasket: response.list.items(.inBasket)
        )
        viewController?.fetch(viewModel: viewModel)
    }
}
