//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct ChatGPTMainView: View {
    
    @StateObject var chatGPTSavedChats = SavedChats()
    
    var filteredChats: [Chat] {
        chatGPTSavedChats.chats.filter { chat in
            return chat.engine != .DALLE
        }
    }
    
    // One ChatViewModel is instantiated for each of the available chat engines as a State Object, keeping interactions with various engines separate
    @StateObject var davinciVM = OpenAIViewModel()
    @StateObject var curieVM = OpenAIViewModel()
    @StateObject var babbageVM = OpenAIViewModel()
    @StateObject var adaVM = OpenAIViewModel()
    
    // When showingDeleteAlert is toggled, an alert is presented to confirm action
    @State private var showingDeleteAlert = false
    @State private var deleteAlertTitle = Text("Chat deleted.")
    
    var body: some View {
        NavigationView {
            List {
                chatGPTEngineSection
                
                savedChatSection
            }
            .navigationTitle("Ask ChatGPT")
        }
        .environmentObject(chatGPTSavedChats)
    }
}

// ChatGPT Engine List Section
extension ChatGPTMainView {
    private var chatGPTEngineSection: some View {

        // NavigationLink will push to a corresponding ChatView
        Section(header: Text("ChatGPT Engines"))  {
            NavigationLink {
                ChatGPTPromptView(viewModel: davinciVM, engine: .davinci)
            } label: {
                EngineLabelView(engine: .davinci)
            }
            
            NavigationLink {
                ChatGPTPromptView(viewModel: curieVM, engine: .curie)
            } label: {
                EngineLabelView(engine: .curie)
            }
            
            NavigationLink {
                ChatGPTPromptView(viewModel: babbageVM, engine: .babbage)
            } label: {
                EngineLabelView(engine: .babbage)
            }
            
            NavigationLink {
                ChatGPTPromptView(viewModel: adaVM, engine: .ada)
            } label: {
                EngineLabelView(engine: .ada)
            }
        }
    }
}

// Saved Chats List Section
extension ChatGPTMainView {
    
    private var savedChatSection: some View {
 
        // If user has chats saved, they will display as a list of NavigationLinks
        // A default message is presented if there are no saved chats
        // Each SavedChatLabel pushes to a SavedChatView
        Section(header: Text("Saved Chats")) {
            if chatGPTSavedChats.chats.isEmpty {
                Text("No saved chats. Start a new chat above.")
            } else {
                ForEach(filteredChats.sorted(by: { $0.date < $1.date }).reversed()) { chat in
                    NavigationLink {
                        SavedChatView(chat: chat, engine: chat.engine)
                    } label: {
                        SavedChatLabel(chat: chat, showingDeleteAlert: $showingDeleteAlert, engine: chat.engine)
                    }
                    .alert(isPresented: $showingDeleteAlert, content: {
                        Alert(title: deleteAlertTitle,
                              primaryButton: .destructive(
                                Text("Undo"),
                                action: {
                                    chatGPTSavedChats.undoDelete()
                                }
                              ),
                              secondaryButton: .default(Text("OK"))
                        )
                    })
                    .contextMenu {
                        
                        // Context Menu presented after a press-and-hold gesture
                        // User may toggle favorite status or detele chat
                        
                        // Mark/Unmark as favorite
                        Button {
                            chatGPTSavedChats.toggleFavorite(chat)
                        } label: {
                            if chat.isFavorite {
                                Label("Unmark as favorite", systemImage: "seal")
                            } else {
                                Label("Mark as Favorite", systemImage: "checkmark.seal")
                            }
                        }
                        
                        // Delete Chat
                        Button(role: .destructive) {
                            chatGPTSavedChats.delete(chat)
                            showingDeleteAlert = true
                        } label: {
                            Label("Delete chat", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        
                        // Swiping from leading edge reveals a favorite toggle
                        Button {
                            chatGPTSavedChats.toggleFavorite(chat)
                        } label: {
                            if chat.isFavorite {
                                Label("Unmark as favorite", systemImage: "seal")
                            } else {
                                Label("Mark as Favorite", systemImage: "checkmark.seal")
                            }
                        }
                        .tint(chat.isFavorite ? .blue : .yellow)
                    }
                    .swipeActions {
                        
                        // Swiping from the trailing edge reveals a delete button
                        Button {
                            chatGPTSavedChats.delete(chat)
                            showingDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }.tint(.red)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTMainView()
            .environmentObject(SavedChats())
    }
}
