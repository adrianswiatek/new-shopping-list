protocol EditItemPresentationLogic {
    func saveItem(response: EditItem.SaveItem.Response)
}

final class EditItemPresenter: EditItemPresentationLogic {
    weak var viewController: EditItemView.Controller?

    func saveItem(response: EditItem.SaveItem.Response) {
        let viewModel = EditItem.SaveItem.ViewModel()
        viewController?.saveItem(viewModel: viewModel)
    }
}
