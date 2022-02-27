import SwiftUI

final class Configurator {
    private let mainRepository: MainRepository

    init() {
        self.mainRepository = CoreDataMainRepository()
    }

    func listsView() -> some View {
        let interactor = ListsInteractor(
            repository: mainRepository,
            remoteChangesListener: RemoteModelChangesListener()
        )
        let presenter = ListsPresenter()
        let controller = ListsView.Controller()

        interactor.presenter = presenter
        presenter.viewController = controller
        controller.interactor = interactor

        return ListsView(controller: controller, configurator: self)
    }

    func addListView() -> some View {
        let interactor = AddListInteractor(
            repository: mainRepository
        )
        let presenter = AddListPresenter()
        let controller = AddListView.Controller()

        interactor.presenter = presenter
        presenter.viewController = controller
        controller.interactor = interactor

        return AddListView(controller: controller)
    }
}
