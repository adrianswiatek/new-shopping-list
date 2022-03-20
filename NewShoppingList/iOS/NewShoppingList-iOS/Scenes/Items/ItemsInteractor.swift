import Combine

protocol ItemsBusinessLogic {
    func fetch(request: Items.Fetch.Request)
}

protocol ItemsDataStore {
    var listId: Id<ShoppingList> { get }
}

final class ItemsInteractor: ItemsBusinessLogic, ItemsDataStore {
    var presenter: ItemsPresentationLogic?
    var listId: Id<ShoppingList>

    private let repository: MainRepository
    private let remoteChangesListener: RemoteModelChangesListener

    private var remoteModelChangesCancallable: AnyCancellable?

    init(
        listId: Id<ShoppingList>,
        repository: MainRepository,
        remoteChangesListener: RemoteModelChangesListener
    ) {
        self.listId = listId
        self.repository = repository
        self.remoteChangesListener = remoteChangesListener

        self.remoteModelChangesCancallable = remoteChangesListener
            .publisher
            .sink { [weak self] _ in
                let request = Items.Fetch.Request()
                self?.fetch(request: request)
            }
    }

    func fetch(request: Items.Fetch.Request) {
        guard let list = repository.list(withId: listId) else {
            return
        }

        let response = Items.Fetch.Response(list: list)
        presenter?.fetch(response: response)
    }
}
