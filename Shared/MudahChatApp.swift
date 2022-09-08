//
//  MudahChatApp.swift
//  Shared
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI

@main
struct MudahChatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
