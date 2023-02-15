//
//  SavedChats.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

@MainActor class SavedChats: ObservableObject {
    @Published private(set) var chats: [Chat]
    
    var recentlyDeleted: Chat?
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedChats")
    
    init() {
        print("SavedChats initializing.")

        // Looks in Documents Directory for stored data
        if let data = try? Data(contentsOf: savePath) {
            print("Looking for SavedChats in Documents Directory.")
            if let decoded = try? JSONDecoder().decode([Chat].self, from: data) {
                chats = decoded
                print("Chats decoded.")
                return
            }
        }
        // If no data is found, chats is an empty array
        print("No data found in Documents Directory")
        chats = []
    }
    
    private func save() {
        // Saves current chats array to documentsDirectory
        if let encoded = try? JSONEncoder().encode(chats) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Chats saved to Documents Directory")
        }
    }
    
    func add(_ chat: Chat) {
        chats.append(chat)
        save()
    }
    
    func delete(_ chat: Chat) {
        if let index = chats.firstIndex(where: { currentChat in
            currentChat.id == chat.id
        }) {
            recentlyDeleted = chat
            chats.remove(at: index)
            save()
        }
    }
    
    // When delete function is called, deleted chat is stored in recentlyDeleted, and showingDeleteAlert will become true
    // When alert is shown, user can acknowledge deletion, or undo.
    // undoDelete() will append the recentlyDeleted chat, nil coalescing to the example Chat
    func undoDelete() {
        chats.append(recentlyDeleted ?? Chat.chatGPTExample)
    }
    
    // Sends outs a change notification so views are refreshed
    func toggleFavorite(_ chat: Chat) {
        // Calling objectWillChange.send() before changing the property ensures correct animations
        objectWillChange.send()
        chat.isFavorite.toggle()
        save()
    }
    
    static let example: () = SavedChats().chats.append(Chat(request: "Twitter bird", response: "", engine: .DALLE, generatedImage: UIImage(named: "twitter")?.pngData()))
}
