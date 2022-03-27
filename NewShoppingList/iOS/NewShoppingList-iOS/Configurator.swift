import SwiftUI

final class Configurator {
    private let mainRepository: MainRepository
    private let remoteModelChangesListener: RemoteModelChangesListener

    init() {
        self.mainRepository = CoreDataMainRepository()
        self.remoteModelChangesListener = RemoteModelChangesListener()
    }

    func listsView() -> some View {
        let interactor = ListsInteractor(
            repository: mainRepository,
            remoteChangesListener: remoteModelChangesListener
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

    func itemsView(list: ShoppingList) -> some View {
        let interactor = ItemsInteractor(
            listId: list.id,
            repository: mainRepository,
            remoteChangesListener: remoteModelChangesListener
        )
        let presenter = ItemsPresenter()
        let controller = ItemsView.Controller(initialListName: list.name)

        interactor.presenter = presenter
        presenter.viewController = controller
        controller.interactor = interactor

        return ItemsView(controller: controller, configurator: self)
    }

    func editItemView(item: ShoppingItem) -> some View {
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
