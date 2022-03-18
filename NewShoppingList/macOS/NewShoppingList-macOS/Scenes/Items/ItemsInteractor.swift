import Combine

protocol ItemsBusinessLogic {
    func add(request: Items.Add.Request)
    func delete(request: Items.Delete.Request)
    func fetch(request: Items.Fetch.Request)
    func moveToBasket(request: Items.MoveToBasket.Request)
    func removeFromBasket(request: Items.RemoveFromBasket.Request)
}

final class ItemsInteractor: ItemsBusinessLogic {
    var presenter: ItemsPresentationLogic?

    var remoteModelChangesCancallable: AnyCancellable?

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
            .sink { [weak self] list in
                let response = Items.Fetch.Response(list: list)
                self?.presenter?.fetch(response: response)
            }
    }

    func add(request: Items.Add.Request) {
        repository.addItem(
            withName: request.itemName,
            toListWithId: request.listId
        )

        guard let list = repository.list(withId: request.listId) else {
            return
        }

        let response = Items.Add.Response(list: list)
        presenter?.add(response: response)
    }

    func delete(request: Items.Delete.Request) {
        repository.deleteItem(withId: request.itemId)

        guard let list = repository.list(withId: request.listId) else {
            return
        }

        let response = Items.Delete.Response(list: list)
        presenter?.delete(response: response)
    }

    func fetch(request: Items.Fetch.Request) {
        guard let list = repository.list(withId: request.listId) else {
            return
        }

        let response = Items.Fetch.Response(list: list)
        presenter?.fetch(response: response)
    }

    func moveToBasket(request: Items.MoveToBasket.Request) {
        repository.changeStateOfItem(withId: request.itemId, to: .inBasket)

        guard let list = repository.list(withId: request.listId) else {
            return
        }

        let response = Items.MoveToBasket.Response(list: list)
        presenter?.moveToBasket(response: response)
    }

    func removeFromBasket(request: Items.RemoveFromBasket.Request) {
        repository.changeStateOfItem(withId: request.itemId, to: .toBuy)

        guard let list = repository.list(withId: request.listId) else {
            return
        }

        let response = Items.RemoveFromBasket.Response(list: list)
        presenter?.removeFromBasket(response: response)
    }
}
