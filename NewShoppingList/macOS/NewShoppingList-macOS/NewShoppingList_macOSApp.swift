import SwiftUI

@main
struct NewShoppingList_macOSApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate: AppDelegate

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView(configurator: Configurator())
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .commands {
            SidebarCommands()
        }
    }
}
