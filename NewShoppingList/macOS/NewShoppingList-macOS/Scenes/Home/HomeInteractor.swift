import Combine

protocol HomeBusinessLogic {
    func addList(request: Home.AddList.Request)
    func deleteList(request: Home.DeleteList.Request)
}

final class HomeInteractor: HomeBusinessLogic {
    var presenter: PresentationLogic?

    private let homeRepository: HomeRepository

    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }

    func addList(request: Home.AddList.Request) {
        homeRepository.addList(withName: request.listName)

        let allLists = homeRepository.allLists()
        let response = Home.AddList.Resposne(lists: allLists)
        presenter?.addList(response: response)
    }

    func deleteList(request: Home.DeleteList.Request) {
        homeRepository.deleteList(withId: request.listId)

        let allLists = homeRepository.allLists()
        let response = Home.DeleteList.Response(lists: allLists)
        presenter?.deleteList(response: response)
    }
}
