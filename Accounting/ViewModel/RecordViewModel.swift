import Foundation
import Combine
import UIKit

class RecordViewModel: ObservableObject {

    // Input
    @Published var date: Date = Date()
    @Published var type: String = ""
    @Published var cost: Int = 0

    init(record: Record? = nil) {

        if let record = record {
            self.date = record.date
            self.type = record.type
            self.cost = record.cost
        }
    }
}
