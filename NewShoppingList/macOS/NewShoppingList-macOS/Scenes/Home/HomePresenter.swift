protocol PresentationLogic {
    func addList(response: Home.AddList.Resposne)
    func deleteList(response: Home.DeleteList.Response)
}

final class HomePresenter: PresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func addList(response: Home.AddList.Resposne) {
        let viewModel = Home.AddList.ViewModel(lists: response.lists)
        self.viewController?.addList(viewModel: viewModel)
    }

    func deleteList(response: Home.DeleteList.Response) {
        let viewModel = Home.DeleteList.ViewModel(lists: response.lists)
        self.viewController?.deleteList(viewModel: viewModel)
    }
}
