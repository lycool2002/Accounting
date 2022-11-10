import Foundation
import CoreData

public class Record: NSManagedObject {

    @NSManaged public var date: Date
    @NSManaged public var type: String
    @NSManaged public var cost: Int

}
