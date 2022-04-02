protocol EditItemBusinessLogic {
    func saveItem(request: EditItem.SaveItem.Request)
}

final class EditItemInteractor: EditItemBusinessLogic {
    var presenter: EditItemPresentationLogic?

    private let repository: MainRepository

    init(repository: MainRepository) {
        self.repository = repository
    }

    func saveItem(request: EditItem.SaveItem.Request) {
        repository.updateItem(request.item)

        let response = EditItem.SaveItem.Response()
        presenter?.saveItem(response: response)
    }
}
