import Combine

protocol ItemsBusinessLogic {
    func delete(request: Items.Delete.Request)
    func fetch(request: Items.Fetch.Request)
    func update(request: Items.Update.Request)
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

    func delete(request: Items.Delete.Request) {
        repository.deleteItem(withId: request.item.id)
    }

    func fetch(request: Items.Fetch.Request) {
        guard let list = repository.list(withId: listId) else {
            return
        }

        let response = Items.Fetch.Response(list: list)
        presenter?.fetch(response: response)
    }

    func update(request: Items.Update.Request) {
        repository.updateItem(request.item)

        let response = Items.Update.Response()
        presenter?.update(response: response)
    }
}
