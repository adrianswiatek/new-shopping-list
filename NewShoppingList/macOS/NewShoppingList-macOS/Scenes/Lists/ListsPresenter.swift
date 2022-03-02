protocol ListsPresentationLogic {
    func addList(response: Lists.AddList.Resposne)
    func deleteList(response: Lists.DeleteList.Response)
    func fetchLists(response: Lists.FetchLists.Response)
}

final class ListsPresenter: ListsPresentationLogic {
    weak var viewController: ListsDisplayLogic?

    func addList(response: Lists.AddList.Resposne) {
        let viewModel = Lists.AddList.ViewModel()
        viewController?.addList(viewModel: viewModel)
    }

    func deleteList(response: Lists.DeleteList.Response) {
        let viewModel = Lists.DeleteList.ViewModel()
        viewController?.deleteList(viewModel: viewModel)
    }

    func fetchLists(response: Lists.FetchLists.Response) {
        let viewModel = Lists.FetchLists.ViewModel(lists: response.lists)
        viewController?.fetchLists(viewModel: viewModel)
    }
}
