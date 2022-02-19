//
//  NewShoppingList_iOSApp.swift
//  NewShoppingList-iOS
//
//  Created by Adrian Świątek on 19/02/2022.
//

import SwiftUI

@main
struct NewShoppingList_iOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
