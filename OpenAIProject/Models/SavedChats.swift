//
//  SavedChats.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

class Chat: Identifiable, Codable {
    var id = UUID()
    var request: String
    var response: String
    var date = Date.now
    var notes = ""
    fileprivate(set) var isFavorite = false
    
    init(id: UUID = UUID(), request: String, response: String, date: Foundation.Date = Date.now, notes: String = "", isFavorite: Bool = false) {
        self.id = id
        self.request = request
        self.response = response
        self.date = date
        self.notes = notes
        self.isFavorite = isFavorite
    }
}

@MainActor class SavedChats: ObservableObject {
    @Published private(set) var chats: [Chat]
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        //looks in documentsDirectory for stored data
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Chat].self, from: data) {
                chats = decoded
                return
            }
        }
        //if no data is in documentsDirectory, chats is an empty array
        chats = []
    }
    
    private func save() {
        //saves current chats array to documentsDirectory
        if let encoded = try? JSONEncoder().encode(chats) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
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
            chats.remove(at: index)
            save()
        }
    }
    
    //sends outs a change notification so views are refreshed
    func toggleFavorite(_ chat: Chat) {
        //calling objectWillChange.send() before changing the property ensures correct animations
        objectWillChange.send()
        chat.isFavorite.toggle()
        save()
    }
    
    
}
