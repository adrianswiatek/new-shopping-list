protocol AddListPresentationLogic {
    func save(response: AddList.Save.Response)
}

final class AddListPresenter: AddListPresentationLogic {
    weak var viewController: AddListView.Controller?

    func save(response: AddList.Save.Response) {

        let viewModel = AddList.Save.ViewModel()
        viewController?.save(viewModel: viewModel)
    }
}
