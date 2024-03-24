import Foundation
import CoreData


class CoreDataViewModel: ObservableObject
{
    // Singleton instances
    let manager = CoreDataManager.instance
    static let shared = CoreDataViewModel()
    
    @Published var tasks: [TaskEntity] = []
    
    init() {
        readTasksFromDatabase()
    }
    
    
    func saveTasks() {
        do {
            try manager.container.viewContext.save()
            readTasksFromDatabase()
        } catch {
            print("DEBUG: Error Saving Core Data Error -> \(error) \nIn saveData() func")
        }
    }
    
    func addTask(title: String) {
        let newTask = TaskEntity(context: manager.container.viewContext)
        newTask.title = title
        
        saveTasks()
    }
    
    func readTasksFromDatabase() {
        let requestToGetData = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        
        do {
            var fetchedTasks = try manager.container.viewContext.fetch(requestToGetData)
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
        offsets.map { tasks[$0] }.forEach(manager.container.viewContext.delete)
        
        do {
            try manager.container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        saveTasks()
    }

}
