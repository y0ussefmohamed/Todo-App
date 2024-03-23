import Foundation
import CoreData


class CoreDataViewModel: ObservableObject
{
    static let shared = CoreDataViewModel() // Singleton instance
    
    let container: NSPersistentContainer
    @Published var tasks: [TaskEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "TaskCoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("DEBUG: Error Loading Core Data Error -> \(error) \nIn init()")
            }
        }
        
        readTasksFromDatabase()
    }
    
    
    func saveTasks() {
        do {
            try container.viewContext.save()
            readTasksFromDatabase()
        } catch {
            print("DEBUG: Error Saving Core Data Error -> \(error) \nIn saveData() func")
        }
    }
    
    func addTask(title: String) {
        let newTask = TaskEntity(context: container.viewContext)
        newTask.title = title
        
        saveTasks()
    }
    
    func readTasksFromDatabase() {
        let requestToGetData = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            var fetchedTasks = try container.viewContext.fetch(requestToGetData)
            fetchedTasks.sort { !$0.isDone && $1.isDone } // Sort tasks, undone tasks first
            
            self.tasks = fetchedTasks
        } catch {
            print("DEBUG: Error Fetching Core Data Error -> \(error) \nIn fetchFruitsFromDatabase() func")
        }
    }
    
    func updateTask(entity: TaskEntity) {
        entity.isDone = !entity.isDone
        
        saveTasks()
    }
    
    func deleteTask(offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(container.viewContext.delete)
        
        do {
            try container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        saveTasks()
    }

}
