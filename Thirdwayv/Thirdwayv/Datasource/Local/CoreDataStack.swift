////
////  CoreDataStack.swift
////  InstabugNetworkClient
////
////  Created by Amin on 12/05/2022.
////
//
import CoreData

class PersistentContainer : NSPersistentContainer{}

public enum CoreDataStackType{
    case TEST
    case PROD
}

public class CoreDataStack {
    
    static let coreDataName = "Thirdwayv"
    private var persistentContainer: NSPersistentContainer!
    var backgroundContext: NSManagedObjectContext!
    var mainContext: NSManagedObjectContext!
    private var type:CoreDataStackType!
    
    public init(type:CoreDataStackType) {
        self.reload(type: type)
    }
    
    func restore(){
        //MARK: in order to recreate the files
        guard let backgroundContext = backgroundContext else {
            return
        }
        guard let persistentContainer = persistentContainer else {
            return
        }

        backgroundContext.performAndWait {
            let storeContainer = persistentContainer.persistentStoreCoordinator
            for store in storeContainer.persistentStores {
                try? storeContainer.destroyPersistentStore(at: store.url!,ofType: store.type,options: nil)
            }
        }
        
        self.reload(type: .PROD)
    }
    private func reload(type:CoreDataStackType){
        self.type = type
        persistentContainer = PersistentContainer(name: Self.coreDataName)
        
        switch type {
        case .TEST:
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
