import SwiftUI

@main
struct NewShoppingListApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                Configurator()
                    .listsView()
//                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
