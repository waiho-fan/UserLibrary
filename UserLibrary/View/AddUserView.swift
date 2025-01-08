//
//  AddUserView.swift
//  UserLibrary
//
//  Created by Gary on 8/1/2025.
//

import PhotosUI
import SwiftData
import SwiftUI

struct AddUserView: View {
    @Environment(\.dismiss) var dismiss

    let savePath = URL.documentsDirectory.appending(path: "SavedUser")
    
    @State var selectedItem: PhotosPickerItem?
    @State var selectedImageData: Data?
    @State var selectedImage: Image?
    @State var name: String = ""
    
    @Binding var users: [User]
        
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Photo") {
                        PhotosPicker(selection: $selectedItem) {
                            if let selectedImage {
                                selectedImage
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                            }
                        }
                        .onChange(of: selectedItem, loadImage)
                    }
                    .listRowBackground(selectedImage != nil ? Color.clear : Color.primary.opacity(0.1))
                    
                    Section("Name") {
                        TextField("Name", text: $name)
                    }
                    
                    HStack {
                        Spacer()
                        Button("Add") {
                            let user = User(name: name, photoData: selectedImageData ?? Data())
                            users.append(user)
                            save()
                            dismiss()
                        }
                        .disabled(disable())
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add User")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }

            selectedImageData = imageData
            selectedImage = Image(uiImage: inputImage)
        }
    }
    
    func disable() -> Bool {
        return name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        || selectedImage == nil
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Save data success：\(users.count) users")
        } catch {
            print("Save data fail：\(error.localizedDescription)")
        }
    }
    
}

#Preview {
    @State var previewUsers: [User] = []
    return AddUserView(users: $previewUsers)
}
