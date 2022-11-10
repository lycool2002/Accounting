import SwiftUI

struct ListView: View {
    
    @FetchRequest(
        entity: Record.entity(),
        sortDescriptors: [],
        animation: .default)
    var record: FetchedResults<Record>
    
    @Environment(\.managedObjectContext) var context
    
    @State private var showNewRestaurant = false
    
    
    var totalCost: Int {
            record.reduce(0) { $0 + $1.cost }
        }
    
    var body: some View {
        NavigationView {
            
            
            List{
                HStack{
                Text("date")
                Spacer()
                Text("type")
                Spacer()
                Spacer()
                Text("Total: \(totalCost)")
                }
                
                ForEach(record.indices, id: \.self) { index in
                    HStack{
                        Text(record[index].date.formatted(.dateTime.day().month()) )
                        Spacer()
                        Text(record[index].type)
                        Spacer()
                        Spacer()
                        Text(String(record[index].cost))
                        
                    }
                }
                .onDelete(perform: deleteRecord)
                .listStyle(.sidebar)
                
            }
            .sheet(isPresented: $showNewRestaurant) {
                NewRecordView()
            }
            .navigationTitle("Record")
            .toolbar {
                Button(action: {
                    self.showNewRestaurant = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    private func deleteRecord(indexSet: IndexSet) {

        for index in indexSet {
            let itemToDelete = record[index]
            context.delete(itemToDelete)
        }

        DispatchQueue.main.async {
            do {
                try context.save()

            } catch {
                print(error)
            }
        }
    }

}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
