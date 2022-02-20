protocol PresentationLogic {
    func addList(response: Home.AddList.Resposne)
    func deleteList(response: Home.DeleteList.Response)
    func fetchLists(response: Home.FetchLists.Response)
}

final class HomePresenter: PresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func addList(response: Home.AddList.Resposne) {
        let viewModel = Home.AddList.ViewModel()
        viewController?.addList(viewModel: viewModel)
    }

    func deleteList(response: Home.DeleteList.Response) {
        let viewModel = Home.DeleteList.ViewModel()
        viewController?.deleteList(viewModel: viewModel)
    }

    func fetchLists(response: Home.FetchLists.Response) {
        let viewModel = Home.FetchLists.ViewModel(lists: response.lists)
        viewController?.fetchLists(viewModel: viewModel)
    }
}
