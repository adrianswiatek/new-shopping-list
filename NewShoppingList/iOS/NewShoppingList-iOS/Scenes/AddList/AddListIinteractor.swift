protocol AddListBusinessLogic {
    func save(request: AddList.Save.Request)
}

final class AddListInteractor: AddListBusinessLogic {
    var presenter: AddListPresentationLogic?

    private let repository: MainRepository

    init(repository: MainRepository) {
        self.repository = repository
    }

    func save(request: AddList.Save.Request) {
        repository.addList(withName: request.listName)

        let response = AddList.Save.Response()
        presenter?.save(response: response)
    }
}
