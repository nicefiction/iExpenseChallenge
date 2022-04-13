// MARK: - LIBRARIES
import Foundation



struct ExpenseItem: Identifiable,
                    Codable {
    
    // MARK: - PROPERTY WRAPPERS
    // MARK: - PROPERTIES
    var id = UUID.init()
    let name: String
    let price: Double
    let type: String
    
    
    
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    // MARK: - METHODS
    // MARK: - HELPERMETHODS
}
