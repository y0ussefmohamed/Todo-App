import Foundation
import CoreData

class CoreDataManager
{
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "TaskCoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("DEBUG: Error Loading Core Data Error -> \(error) \nIn init()")
            }
        }
    }
}
