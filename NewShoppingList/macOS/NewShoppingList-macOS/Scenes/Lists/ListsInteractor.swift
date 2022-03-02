import Combine

protocol ListsBusinessLogic {
    func addList(request: Lists.AddList.Request)
    func deleteList(request: Lists.DeleteList.Request)
    func fetchLists(request: Lists.FetchLists.Request)
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

    func addList(request: Lists.AddList.Request) {
        repository.addList(withName: request.listName)

        let response = Lists.AddList.Resposne()
        presenter?.addList(response: response)
    }

    func deleteList(request: Lists.DeleteList.Request) {
        repository.deleteList(withId: request.listId)

        let response = Lists.DeleteList.Response()
        presenter?.deleteList(response: response)
    }

    func fetchLists(request: Lists.FetchLists.Request) {
        let lists = repository.allLists()
        let response = Lists.FetchLists.Response(lists: lists)
        presenter?.fetchLists(response: response)
    }
}

extension ListsInteractor: RemoteModelChangesListenerDelegate {
    func shoppingListsDidChangeFromRemote(_ listener: RemoteModelChangesListener) {
        let request = Lists.FetchLists.Request()
        fetchLists(request: request)
    }
}
