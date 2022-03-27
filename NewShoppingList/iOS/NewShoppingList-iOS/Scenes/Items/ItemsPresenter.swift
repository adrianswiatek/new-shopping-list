protocol ItemsPresentationLogic {
    func delete(response: Items.Delete.Response)
    func fetch(response: Items.Fetch.Response)
    func update(response: Items.Update.Response)
}

final class ItemsPresenter: ItemsPresentationLogic {
    weak var viewController: ItemsView.Controller?

    func delete(response: Items.Delete.Response) {
        let viewModel = Items.Delete.ViewModel()
        viewController?.delete(viewModel: viewModel)
    }

    func fetch(response: Items.Fetch.Response) {
        let viewModel = Items.Fetch.ViewModel(
            listName: response.list.name,
            itemsToBuy: response.list.items(.toBuy),
            itemsInBasket: response.list.items(.inBasket)
        )
        viewController?.fetch(viewModel: viewModel)
    }

    func update(response: Items.Update.Response) {
        let viewModel = Items.Update.ViewModel()
        viewController?.update(viewModel: viewModel)
    }
}
