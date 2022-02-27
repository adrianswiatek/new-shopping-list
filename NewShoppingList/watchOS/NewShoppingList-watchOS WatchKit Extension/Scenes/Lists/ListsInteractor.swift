protocol ListsBusinessLogic {
    func delete(request: Lists.Delete.Request)
    func fetch(request: Lists.Fetch.Request)
}

final class ListsInteractor: ListsBusinessLogic {
    var presenter: ListsPresentationLogic?

    private let repository: MainRepository
    private let remoteChangesListener: RemoteModelChangesListener

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
        self.remoteChangesListener.delegate = self
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

extension ListsInteractor: RemoteModelChangesListenerDelegate {
    func shoppingListsDidChangeFromRemote(_ listener: RemoteModelChangesListener) {
        let request = Lists.Fetch.Request()
        fetch(request: request)
    }
}
