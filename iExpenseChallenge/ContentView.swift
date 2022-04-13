/// SOURCE:
/// https://www.hackingwithswift.com/books/ios-swiftui/iexpense-wrap-up

import SwiftUI



struct ContentView: View {
    
    // MARK: - PROPERTY WRAPPERS
    @StateObject var expenses = Expenses.init()
    
    @State private var isShowingAddExpenseItemView: Bool = false
    
    
    
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    var body: some View {
        
        let businessExpenses = expenses.items.filter {
            $0.type == "business"
        }
        
        
        let personalExpenses = expenses.items.filter {
            $0.type == "personal"
        }
        
        
        NavigationView {
            List {
                Section("business") {
                    ForEach(businessExpenses) { (eachItem: ExpenseItem) in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(eachItem.name)")
                                    .font(.headline)
//                                Text("\(eachItem.type)")
                                Text("\(Date.now.formatted())")
                                    .font(.subheadline.smallCaps())
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("\(eachItem.price, format: .currency(code: "EUR"))")
                                .font(.title)
                                .foregroundColor(stylePrice(of: eachItem))
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
                
                Section("personal") {
                    ForEach(personalExpenses) { (eachItem: ExpenseItem) in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(eachItem.name)")
                                    .font(.headline)
//                                Text("\(eachItem.type)")
                                Text("\(Date.now.formatted())")
                                    .font(.subheadline.smallCaps())
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("\(eachItem.price, format: .currency(code: "EUR"))")
                                .font(.title)
                                .foregroundColor(stylePrice(of: eachItem))
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
            }
            .navigationTitle(Text("iExpense"))
            .toolbar {
                Button {
                    isShowingAddExpenseItemView.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.title)
                }
            }
            .sheet(isPresented: $isShowingAddExpenseItemView) {
                AddExpenseItemView(expenses: expenses)
            }
        }
    }
    
    
    
    // MARK: - METHODS
    func removeItems(at offsets: IndexSet)
    -> Void {

        expenses.items.remove(atOffsets: offsets)
    }
    
    
//    func removeBusinessItems(at offsets: IndexSet)
//    -> Void {
//
//        var businessExpenses = expenses.items.filter {
//            $0.type == "business"
//        }
//        businessExpenses.remove(atOffsets: offsets)
//    }
    
    
    func removeBusinessItems(at offsets: IndexSet)
    -> Void {
        
        var businessExpenses = expenses.items.filter {
            $0.type == "business"
        }
        businessExpenses.remove(atOffsets: offsets)
        expenses.items = businessExpenses + expenses.items.filter {
            $0.type == "personal"
        }
    }
    
    
    func removePersonalItems(at offsets: IndexSet)
    -> Void {
        
        var personalExpenses = expenses.items.filter {
            $0.type == "personal"
        }
        personalExpenses.remove(atOffsets: offsets)
        expenses.items = personalExpenses + expenses.items.filter {
            $0.type == "business"
        }
    }
    
    
    func stylePrice(of item: ExpenseItem)
    -> Color {
        
        switch item.price {
        case 0...10: return Color.green
        case 11...50: return Color.blue
        case 51...100: return Color.orange
        default: return Color.red
        }
    }
    
    
    
    // MARK: - HELPERMETHODS
}






// MARK: - PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
