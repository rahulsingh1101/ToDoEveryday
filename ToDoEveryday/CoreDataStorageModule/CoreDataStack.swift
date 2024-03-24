//
//  CoreDataStack.swift
//  ToDoEveryday
//
//  Created by Rahul Singh on 24/03/24.
//

import Foundation
import CoreData

// CoreDataManager.swift

import Foundation
import CoreData

class CoreDataManager {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func getViewContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



// MARK: - Protocols

protocol UserInputRepository {
    func save(value: String)
    func getAllUserInputs() -> [UserInput]
    // Add other CRUD operations as needed
}

class UserInputCoreDataRepository: UserInputRepository {
    private let coreDataManager: CoreDataManager
    
    init(modelName: String) {
        self.coreDataManager = CoreDataManager(modelName: modelName)
    }
    
    func save(value: String) {
        let context = coreDataManager.newBackgroundContext()
        context.perform {
            let userInput = UserInput(context: context)
            userInput.value = value
            self.coreDataManager.saveContext(context)
        }
    }
    
    func getAllUserInputs() -> [UserInput] {
        let context = coreDataManager.getViewContext() // Using getViewContext() to access the view context
        let fetchRequest: NSFetchRequest<UserInput> = UserInput.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
