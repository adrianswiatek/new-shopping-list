import Combine

protocol ListsBusinessLogic {
    func addList(request: Lists.Add.Request)
    func deleteList(request: Lists.Delete.Request)
    func fetchLists(request: Lists.Fetch.Request)
}

final class ListsInteractor: ListsBusinessLogic {
    var presenter: ListsPresentationLogic?

    private var remoteModelChangesCancallable: AnyCancellable?
    private let repository: MainRepository
    private let remoteChangesListener: RemoteModelChangesListener

    init(
        repository: MainRepository,
        remoteChangesListener: RemoteModelChangesListener
    ) {
        self.repository = repository
        self.remoteChangesListener = remoteChangesListener

        self.remoteModelChangesCancallable = remoteChangesListener
            .publisher
            .sink { [weak self] _ in
                let request = Lists.Fetch.Request()
                self?.fetchLists(request: request)
            }
    }

    func addList(request: Lists.Add.Request) {
        repository.addList(withName: request.listName)

        let response = Lists.Add.Resposne()
        presenter?.addList(response: response)
    }

    func deleteList(request: Lists.Delete.Request) {
        repository.deleteList(withId: request.listId)

        let response = Lists.Delete.Response()
        presenter?.deleteList(response: response)
    }

    func fetchLists(request: Lists.Fetch.Request) {
        let lists = repository.allLists()
        let response = Lists.Fetch.Response(lists: lists)
        presenter?.fetchLists(response: response)
    }
}
