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
        let viewController = ListsView.Controller()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        return ListsView(controller: viewController)
    }
}
