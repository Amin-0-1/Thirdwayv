////
////  CoreDataStack.swift
////  InstabugNetworkClient
////
////  Created by Amin on 12/05/2022.
////
//
import CoreData

class PersistentContainer : NSPersistentContainer{}
public class CoreDataStack {
    
    static let coreDataName = "LocalData"
    private var persistentContainer: NSPersistentContainer!
    var backgroundContext: NSManagedObjectContext!
    var mainContext: NSManagedObjectContext!
    private var type:CoreDataStackType!
    
    public init(type:CoreDataStackType) {
        persistentContainer = PersistentContainer(name: Self.coreDataName)
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {return}
        }
        backgroundContext = persistentContainer.newBackgroundContext()
        self.restore()
        self.reload(type: type)
    }
    
    private func restore(){
        //MARK: in order to recreate the files
        backgroundContext.performAndWait {
            let storeContainer = persistentContainer.persistentStoreCoordinator
            for store in storeContainer.persistentStores {
                try? storeContainer.destroyPersistentStore(at: store.url!,ofType: store.type,options: nil)
            }
        }
    }
    private func reload(type:CoreDataStackType){
        self.type = type
        persistentContainer = PersistentContainer(name: Self.coreDataName)
        
        switch type {
        case .test:
            let description = persistentContainer.persistentStoreDescriptions.first
            description?.type = NSInMemoryStoreType
        default:
            break
        }
        
        self.persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        
        mainContext = persistentContainer.viewContext
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
    }
}
