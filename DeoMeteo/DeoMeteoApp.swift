//
//  DeoMeteoApp.swift
//  DeoMeteo
//
//  Created by Tristan on 13/12/2020.
//

import SwiftUI
import CoreData

@main
struct DeoMeteoApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}

let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "FavoriteDataModel")
    container.loadPersistentStores { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    return container
}()

func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(error), \(nserror.userInfo)")
        }
    }
}
