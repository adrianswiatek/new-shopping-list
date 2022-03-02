import SwiftUI

final class Configurator {
    private let mainRepository: MainRepository
    private let remoteChangesListener: RemoteModelChangesListener

    init() {
        self.mainRepository = CoreDataMainRepository()
        self.remoteChangesListener = RemoteModelChangesListener()
    }

    func listsView() -> some View {
        let interactor = ListsInteractor(
            repository: mainRepository,
            remoteChangesListener: remoteChangesListener
        )
        let presenter = ListsPresenter()
        let controller = ListsView.Controller()

        interactor.presenter = presenter
        presenter.viewController = controller
        controller.interactor = interactor

        return ListsView(controller: controller, configurator: self)
    }

    func itemsView(forList list: ShoppingList) -> some View {
        let interactor = ItemsInteractor()
        let presenter = ItemsPresenter()
        let controller = ItemsView.Controller(list: list)

        controller.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = controller

        return ItemsView(controller: controller)
    }
}
