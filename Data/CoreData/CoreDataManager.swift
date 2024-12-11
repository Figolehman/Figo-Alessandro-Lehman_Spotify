//
//  CoreDataManager.swift
//  Data
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import CoreData
import Domain

public class CoreDataManager {
  let container: NSPersistentContainer
  let context: NSManagedObjectContext

  public static let shared = CoreDataManager()

  private init() {
    container = NSPersistentContainer(name: "SpotifyContainer")
    container.loadPersistentStores { description, error in
      guard error == nil else {
        print(error?.localizedDescription ?? "")
        return
      }

      print("Successfully loaded core data!")
    }
    context = container.viewContext
  }

  func save() {
    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
  }
}
