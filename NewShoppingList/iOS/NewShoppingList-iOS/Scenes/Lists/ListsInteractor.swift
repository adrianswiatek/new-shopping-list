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

    init(
        repository: MainRepository,
        remoteChangesListener: RemoteModelChangesListener
    ) {
        self.repository = repository
        self.remoteChangesListener = remoteChangesListener

        self.remoteModelChangesCancallable = remoteChangesListener
            .publisher
            .sink { [weak self] _ in
                let request = Lists.Fetch.Request(variant: .all)
                self?.fetch(request: request)
            }
    }

    func delete(request: Lists.Delete.Request) {
        repository.deleteList(withId: request.listId)

        let response = Lists.Delete.Response()
        presenter?.delete(response: response)
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
