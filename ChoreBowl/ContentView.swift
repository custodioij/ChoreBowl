//
//  ContentView.swift
//  ChoreBowl
//
//  Created by Igor Custodio João on 20/02/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var chorename: String = ""
    @FocusState private var choreFieldIsFocused: Bool
    @State private var showingPopover = false
    
//    @State var choreList: [String] = [] // holds all chores entered
    @StateObject private var choreListManager = ChoreListManager() // Use @StateObject for choreListManager

    
    func showRandomChore() {
        if let randomChore = choreListManager.choreList.randomElement() {
                let alert = UIAlertController(title: "Your chore is:", message: randomChore, preferredStyle: .alert)
            // Add two buttons that do nothing
                alert.addAction(UIAlertAction(title: "Do it", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Put it back", style: .default, handler: nil))

                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    
    var body: some View {
        VStack {
            TextField(
                    "Add a new chore",
                    text: $chorename
                )
            .focused($choreFieldIsFocused)
//            .submitLabel(.done)  // Adding submitLabel for better UX
            .onSubmit {
                if !chorename.isEmpty { // need to make sure we have something here
                    choreListManager.choreList.append(chorename) // store it in our data holder
                    chorename = "" // clear the text field after appending
                    }
            }
            
            Text(chorename)
                    .foregroundColor(choreFieldIsFocused ? .red : .blue)
                    .onAppear{
                        choreFieldIsFocused = false
                    }
            
            Button(action: showRandomChore) {
                Image("bowl_small")
            }
//            Image("bowl_small")
////                .imageScale(.small)
//                .foregroundStyle(.tint)
            
            Text("Pick a chore from the bowl")
            
            List {
                ForEach(choreListManager.choreList, id: \.self) { chore in
                    Text(chore)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
