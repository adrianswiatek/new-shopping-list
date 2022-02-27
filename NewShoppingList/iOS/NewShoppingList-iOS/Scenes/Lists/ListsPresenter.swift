protocol ListsPresentationLogic {
    func delete(response: Lists.Delete.Response)
    func fetch(response: Lists.Fetch.Response)
}

final class ListsPresenter: ListsPresentationLogic {
    weak var viewController: ListsDisplayLogic?

    func delete(response: Lists.Delete.Response) {
        let viewModel = Lists.Delete.ViewModel()
        viewController?.delete(viewModel: viewModel)
    }

    func fetch(response: Lists.Fetch.Response) {
        let viewModel = Lists.Fetch.ViewModel(lists: response.lists)
        viewController?.fetch(viewModel: viewModel)
    }
}
