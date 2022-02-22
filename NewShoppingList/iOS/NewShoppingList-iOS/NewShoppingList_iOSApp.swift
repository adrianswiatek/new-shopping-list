import SwiftUI

@main
struct NewShoppingList_iOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            rootView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }

    private func rootView() -> some View {
        let interactor = ListsInteractor(
            repository: CoreDataMainRepository(),
            remoteChangesListener: RemoteModelChangesListener()
        )
        let presenter = ListsPresenter()
        let controller = ListsView.Controller()

        interactor.presenter = presenter
        presenter.viewController = controller
        controller.interactor = interactor

        return ListsView(controller: controller)
    }
}
