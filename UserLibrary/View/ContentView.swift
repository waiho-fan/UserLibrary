//
//  ContentView.swift
//  UserLibrary
//
//  Created by iOS Dev Ninja on 8/1/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State var users = [User]()
    @State private var showAddView = false
    var sortedUsers: [User] {
        users.sorted { $0.name < $1.name}
    }
    
    let savePath = URL.documentsDirectory.appending(path: "SavedUser")
    
    func loadUsers() {
        do {
            let data = try Data(contentsOf: savePath)
            users = try JSONDecoder().decode([User].self, from: data)
            print("Load data success：\(users.count) users")
        } catch {
            users = []
            print("Load data fail：\(error.localizedDescription)")
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedUsers) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        user.photoImage?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.gray, lineWidth: 1))
                            .shadow(radius: 2)
                        Text(user.name)
                            .font(.headline)
                    }

                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("User Store")
            .toolbar {
                Button {
                    showAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView, content: {
                AddUserView(users: $users)
            })
        }
        .onAppear(perform: loadUsers)
    }

    func removeItems(at indexSet: IndexSet) {
            let sortedIndices = Array(sortedUsers)
            let toDelete = indexSet.map { sortedIndices[$0] }
            
            users.removeAll { user in
                toDelete.contains { $0.id == user.id }
            }
            
            save()
        }
}

#Preview {
    return ContentView()
}
