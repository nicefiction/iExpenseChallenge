// MARK: - LIBRARIES
import SwiftUI
/*
 let name: String
 let price: Double
 let type: String
 */


struct AddExpenseItemView: View {
    
    // MARK: - PROPERTY WRAPPERS
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    
    @State private var name: String = ""
    @State private var price: Double = 0.00
    @State private var selectedExpenseType: String = ExpenseType.personal.rawValue
    
    
    
    // MARK: - PROPERTIES
    let expenseTypes: Array<ExpenseType.RawValue> = [
        ExpenseType.business.rawValue, ExpenseType.personal.rawValue
    ]
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var body: some View {
        
        NavigationView {
            Form {
                Section("item") {
                    VStack(spacing: 15) {
                        TextField("Name of the item...",
                                  text: $name)
                        Picker("Type of the item...",
                               selection: $selectedExpenseType) {
                            ForEach(expenseTypes,
                                    id: \.self) { (eachExpenseType: String) in
                                Text(eachExpenseType.capitalized)
                            }
                        }
                    }
                }
                .pickerStyle(.segmented)
                Section("price") {
                    TextField("Price of the item...",
                              value: $price,
                              format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                    .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(Text("Add Expense Item"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let newExpenseItem = ExpenseItem.init(name: name,
                                                          price: price,
                                                          type: selectedExpenseType)
                    expenses.items.append(newExpenseItem)
                    dismiss()
                }
            }
        }
    }
    
    
    
    // MARK: - METHODS
    // MARK: - HELPERMETHODS
}





// MARK: - PREVIEWS
struct AddExpenseItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        AddExpenseItemView(expenses: Expenses.init())
    }
}
