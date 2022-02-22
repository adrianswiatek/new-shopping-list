protocol ListsPresentationLogic {
    func fetch(response: Lists.Fetch.Response)
}

final class ListsPresenter: ListsPresentationLogic {
    weak var viewController: ListsDisplayLogic?

    func fetch(response: Lists.Fetch.Response) {
        let viewModel = Lists.Fetch.ViewModel(lists: response.lists)
        viewController?.fetch(viewModel: viewModel)
    }
}
