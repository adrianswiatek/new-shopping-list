protocol ListsBusinessLogic {
    func fetch(request: Lists.Fetch.Request)
}

final class ListsInteractor: ListsBusinessLogic {
    var presenter: ListsPresentationLogic?

    private let repository: MainRepository
    private let remoteChangesListener: RemoteModelChangesListener

    init(
        repository: MainRepository,
        remoteChangesListener: RemoteModelChangesListener
    ) {
        self.repository = repository
        self.remoteChangesListener = remoteChangesListener
        self.remoteChangesListener.delegate = self
    }

    func fetch(request: Lists.Fetch.Request) {
        let sendResponse: ([ShoppingList]) -> Void = { [weak self] in
            let response = Lists.Fetch.Response(lists: $0)
            self?.presenter?.fetch(response: response)
        }

        switch request.variant {
        case .all:
            sendResponse(repository.allLists())
        case .single(let listId):
            guard let list = repository.list(withId: listId) else {
                return
            }
            sendResponse([list])
        }
    }
}

extension ListsInteractor: RemoteModelChangesListenerDelegate {
    func shoppingListsDidChangeFromRemote(_ listener: RemoteModelChangesListener) {
        let request = Lists.Fetch.Request(variant: .all)
        fetch(request: request)
    }
}
