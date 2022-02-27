import SwiftUI

final class Configurator {
    private let mainRepository: MainRepository
    private let remoteModelChangesListener: RemoteModelChangesListener

    private var listsViewCache: ListsView?
    private var addListViewCache: AddListView?

    init() {
        self.mainRepository = CoreDataMainRepository()
        self.remoteModelChangesListener = RemoteModelChangesListener()
    }

    func listsView() -> some View {
        if let listsViewCache = listsViewCache {
            return listsViewCache
        }

        let interactor = ListsInteractor(
            repository: mainRepository,
            remoteChangesListener: remoteModelChangesListener
        )
        let presenter = ListsPresenter()
        let controller = ListsView.Controller()

        interactor.presenter = presenter
        presenter.viewController = controller
        controller.interactor = interactor

        let view = ListsView(controller: controller, configurator: self)
        listsViewCache = view

        return view
    }

    func addListView() -> some View {
        if let addListViewCache = addListViewCache {
            return addListViewCache
        }

        let interactor = AddListInteractor(
            repository: mainRepository
        )
        let presenter = AddListPresenter()
        let controller = AddListView.Controller()

        interactor.presenter = presenter
        presenter.viewController = controller
        controller.interactor = interactor

        let view = AddListView(controller: controller)
        addListViewCache = view

        return view
    }
}
