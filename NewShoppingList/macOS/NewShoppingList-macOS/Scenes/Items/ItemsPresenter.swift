protocol ItemsPresentationLogic {
    func add(response: Items.Add.Response)
    func delete(response: Items.Delete.Response)
    func fetch(response: Items.Fetch.Response)
    func update(response: Items.Update.Response)
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

    func update(response: Items.Update.Response) {
        let viewModel = Items.Update.ViewModel(list: response.list)
        viewController?.update(viewModel: viewModel)
    }
}
