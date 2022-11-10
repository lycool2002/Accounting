import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()
// MARK: preview
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        let record = Record(context: viewContext)

        record.date = Date() 
        record.type = "breakfast"
        record.cost = 0
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    static var testData: [Record]? = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        return try? PersistenceController.preview.container.viewContext.fetch(fetchRequest) as? [Record]
    }()//prview done
     


    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Accounting")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
