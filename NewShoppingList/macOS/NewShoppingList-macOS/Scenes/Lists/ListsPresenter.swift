protocol ListsPresentationLogic {
    func addList(response: Lists.Add.Resposne)
    func deleteList(response: Lists.Delete.Response)
    func fetchLists(response: Lists.Fetch.Response)
}

final class ListsPresenter: ListsPresentationLogic {
    weak var viewController: ListsDisplayLogic?

    func addList(response: Lists.Add.Resposne) {
        let viewModel = Lists.Add.ViewModel()
        viewController?.addList(viewModel: viewModel)
    }

    func deleteList(response: Lists.Delete.Response) {
        let viewModel = Lists.Delete.ViewModel()
        viewController?.deleteList(viewModel: viewModel)
    }

    func fetchLists(response: Lists.Fetch.Response) {
        let viewModel = Lists.Fetch.ViewModel(lists: response.lists)
        viewController?.fetchLists(viewModel: viewModel)
    }
}
