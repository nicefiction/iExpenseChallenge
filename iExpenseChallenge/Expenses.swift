// MARK: - LIBRARIES
import Foundation



class Expenses: ObservableObject {
    
    // MARK: - PROPERTY WRAPPERS
    @Published var items = Array<ExpenseItem>() {
        didSet {
            let jsonEncoder = JSONEncoder.init()
            
            if let _encodedData = try? jsonEncoder.encode(items) {
                UserDefaults.standard.set(_encodedData, forKey: "Items")
            }
        }
    }
    
    
    
    // MARK: - PROPERTIES
    // MARK: - INITIALIZERS
    init() {
        
        if let _savedData = UserDefaults.standard.data(forKey: "Items") {
            let jsonDecoder = JSONDecoder.init()
            if let _decodedData = try? jsonDecoder.decode(Array<ExpenseItem>.self,
                                                          from: _savedData) {
                self.items = _decodedData
                return
            }
        }
        self.items = items
    }
    
    
    
    // MARK: - COMPUTED PROPERTIES
    // MARK: - METHODS
    // MARK: - HELPERMETHODS
    
}
