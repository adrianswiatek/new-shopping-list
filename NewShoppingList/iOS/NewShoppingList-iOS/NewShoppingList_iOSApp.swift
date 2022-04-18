import SwiftUI

@main
struct NewShoppingList_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            Configurator()
                .listsView()
        }
    }
}
