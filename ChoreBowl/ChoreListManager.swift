import SwiftUI

class ChoreListManager: ObservableObject {
    @Published var choreList: [String] {
        didSet {
            // Save choreList to UserDefaults whenever it changes
            UserDefaults.standard.set(choreList, forKey: "choreList")
        }
    }
    
    init() {
        // Load choreList from UserDefaults when initializing
        self.choreList = UserDefaults.standard.array(forKey: "choreList") as? [String] ?? []
    }
}
