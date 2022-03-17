protocol ItemsPresentationLogic {
    func add(response: Items.Add.Response)
    func delete(response: Items.Delete.Response)
    func fetch(response: Items.Fetch.Response)
    func moveToBasket(response: Items.MoveToBasket.Response)
}

final class ItemsPresenter: ItemsPresentationLogic {
    weak var viewController: ItemsView.Controller?

    func add(response: Items.Add.Response) {
        let viewModel = Items.Add.ViewModel(list: response.list)
        viewController?.add(viewModel: viewModel)
    }

    func delete(response: Items.Delete.Response) {
        let viewModel = Items.Delete.ViewModel(list: response.list)
        viewController?.delete(viewModel: viewModel)
    }

    func fetch(response: Items.Fetch.Response) {
        let viewModel = Items.Fetch.ViewModel(list: response.list)
        viewController?.fetch(viewModel: viewModel)
    }

    func moveToBasket(response: Items.MoveToBasket.Response) {
        let viewModel = Items.MoveToBasket.ViewModel(list: response.list)
        viewController?.moveToBasket(viewModel: viewModel)
    }
}
