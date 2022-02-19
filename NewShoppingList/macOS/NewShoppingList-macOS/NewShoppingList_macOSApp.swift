import SwiftUI

@main
struct NewShoppingList_macOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .commands {
            SidebarCommands()
        }
    }
}
