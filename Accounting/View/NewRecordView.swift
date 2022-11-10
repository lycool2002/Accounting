import SwiftUI

struct NewRecordView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var recordViewModel: RecordViewModel
    @Environment(\.managedObjectContext) var context
    
    init() {
        let viewModel = RecordViewModel()
        recordViewModel = viewModel
    }
    
    private func save() {
        let record = Record(context: context)

        record.date = recordViewModel.date
        record.type = recordViewModel.type
        record.cost = recordViewModel.cost


        do {
            try context.save()
        } catch {
            print("Failed to save the record...")
            print(error.localizedDescription)
        }
    }


    var body: some View {
        NavigationView {

            ScrollView {
                VStack {
                    HStack{
                        DatePicker("",selection: $recordViewModel.date,displayedComponents: [.date])
                            .labelsHidden()
                        Spacer()

                    }
                    .padding(.bottom)
                    

                    FormTextField(label: "type", placeholder: "Fill the type", value: $recordViewModel.type)

                    NumFormTextField(label: "cost", placeholder: "Fill the cost", num: $recordViewModel.cost)

                }
                .padding()

            }

            // Navigation bar configuration
            .navigationTitle("New Record")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .accentColor(.primary)
                    }

                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                            save()
                            dismiss()
                        }) {
                        Text("Save")
                            .font(.headline)
                        }
                }
            }
        }
    }
    
    
}
    

struct FormTextField: View {
    let label: String
    var placeholder: String = ""

    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))

            TextField(placeholder, text: $value)
                .font(.system(.body, design: .rounded))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.vertical, 10)

        }
    }
}

struct NumFormTextField: View {
    let label: String
    var placeholder: String = ""

    @Binding var num: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))

            TextField(placeholder,
                      value: $num, format: .number)
                .keyboardType(.numberPad)
                .font(.system(.body, design: .rounded))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.vertical, 10)
                .keyboardType(.numberPad)

        }
    }
}





struct NewRecordView_Previews: PreviewProvider {
    static var previews: some View {
    NewRecordView()
    FormTextField(label: "NAME", placeholder: "Fill the date", value: .constant(""))
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
