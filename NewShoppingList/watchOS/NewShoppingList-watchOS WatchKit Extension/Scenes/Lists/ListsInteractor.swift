import Combine

protocol ListsBusinessLogic {
    func delete(request: Lists.Delete.Request)
    func fetch(request: Lists.Fetch.Request)
}

final class ListsInteractor: ListsBusinessLogic {
    var presenter: ListsPresentationLogic?

    private let repository: MainRepository
    private let remoteChangesListener: RemoteModelChangesListener

    private var remoteModelChangesCancallable: AnyCancellable?
    private var temporaryListsStorage: [ShoppingList]

    init(
        repository: MainRepository,
        remoteChangesListener: RemoteModelChangesListener
    ) {
        self.repository = repository
        self.remoteChangesListener = remoteChangesListener

        self.temporaryListsStorage = [
            ShoppingList.Factory.new(withName: "Test list 1"),
            ShoppingList.Factory.new(withName: "Test list 2"),
            ShoppingList.Factory.new(withName: "Test list 3"),
        ]

        self.remoteModelChangesCancallable = remoteChangesListener
            .publisher
            .sink { [weak self] list in
                let request = Lists.Fetch.Request()
                self?.fetch(request: request)
            }
    }

    func delete(request: Lists.Delete.Request) {
        temporaryListsStorage.removeAll {
            $0.id == request.listId
        }

        let response = Lists.Delete.Response()
        presenter?.delete(response: response)
    }

    func fetch(request: Lists.Fetch.Request) {
        let response = Lists.Fetch.Response(lists: temporaryListsStorage)
        presenter?.fetch(response: response)
    }
}
