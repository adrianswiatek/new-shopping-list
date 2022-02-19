//
//  NewShoppingListApp.swift
//  NewShoppingList-watchOS WatchKit Extension
//
//  Created by Adrian Świątek on 19/02/2022.
//

import SwiftUI

@main
struct NewShoppingListApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
