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
        
        NavigationView {
            List {
                ForEach(expenses.items) { (eachItem: ExpenseItem) in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(eachItem.name)")
                                .font(.headline)
                            Text("\(eachItem.type)")
                                .font(.subheadline.smallCaps())
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("\(eachItem.price, format: .currency(code: "EUR"))")
                            .font(.title)
                            .foregroundColor(stylePrice(of: eachItem))
                    }
                }
                .onDelete(perform: removeItems)
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
/*
 expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style.
 */




// MARK: - PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
