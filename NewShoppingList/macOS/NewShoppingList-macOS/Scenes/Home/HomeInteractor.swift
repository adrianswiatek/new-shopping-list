import Combine

protocol HomeBusinessLogic {
    func addList(request: Home.AddList.Request)
    func deleteList(request: Home.DeleteList.Request)
    func fetchLists(request: Home.FetchLists.Request)
}

final class HomeInteractor: HomeBusinessLogic {
    var presenter: PresentationLogic?

    private let repository: HomeRepository
    private let remoteChangesListener: RemoteHomeModelChangesListener

    init(
        repository: HomeRepository,
        remoteChangesListener: RemoteHomeModelChangesListener
    ) {
        self.repository = repository
        self.remoteChangesListener = remoteChangesListener
        self.remoteChangesListener.delegate = self
    }

    func addList(request: Home.AddList.Request) {
        repository.addList(withName: request.listName)

        let response = Home.AddList.Resposne()
        presenter?.addList(response: response)
    }

    func deleteList(request: Home.DeleteList.Request) {
        repository.deleteList(withId: request.listId)

        let response = Home.DeleteList.Response()
        presenter?.deleteList(response: response)
    }

    func fetchLists(request: Home.FetchLists.Request) {
        let lists = repository.allLists()
        let response = Home.FetchLists.Response(lists: lists)
        presenter?.fetchLists(response: response)
    }
}

extension HomeInteractor: RemoteHomeModelChangesListenerDelegate {
    func shoppingListsDidChangeFromRemote(_ listener: RemoteHomeModelChangesListener) {
        let request = Home.FetchLists.Request()
        fetchLists(request: request)
    }
}
