import SwiftUI

@main
struct NewShoppingList_macOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            rootView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .commands {
            SidebarCommands()
        }
    }

    private func rootView() -> some View {
        let interactor = HomeInteractor(
            repository: CoreDataHomeRepository(),
            remoteChangesListener: RemoteHomeModelChangesListener()
        )
        let presenter = HomePresenter()
        let controller = HomeView.Controller()

        interactor.presenter = presenter
        presenter.viewController = controller
        controller.interactor = interactor

        return HomeView(controller: controller)
    }
}
