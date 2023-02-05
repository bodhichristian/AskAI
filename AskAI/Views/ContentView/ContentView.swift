//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct ContentView: View {
    // ContentView is passed a savedChats EnvironmentObject from AskAIApp
    @EnvironmentObject var savedChats: SavedChats
    
    // One ChatViewModel is instantiated for each of the available chat engines as a State Object, keeping interactions with various engines separate
    @StateObject var davinciVM = ChatViewModel()
    @StateObject var curieVM = ChatViewModel()
    @StateObject var babbageVM = ChatViewModel()
    @StateObject var adaVM = ChatViewModel()
    
    // When showingInfoView is toggled, a modal sheet will present InfoView
    @State private var showingInfoView = false
    
    // When showingDeleteAlert is toggled, an alert is presented to confirm action
    @State private var showingDeleteAlert = false
    @State private var deleteAlertTitle = Text("Chat deleted.")
    
    var body: some View {
        NavigationView {
            List {
                chatGPTEngineSection
                savedChatSection
            }
            .navigationTitle("AskAI")
            .toolbar {
                Button {
                    showingInfoView.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            .sheet(isPresented: $showingInfoView) {
                InfoView()
            }
        }
        .environmentObject(savedChats)
    }
}

extension ContentView {
    private var savedChatSection: some View {
        
        // Saved Chats
        // If user has saved previous chats, they will display as a list of NavigationLinks
        // Each chat is a NavigationLink, organized by date, pushing to a SavedChatView
        Section(header: Text("Saved Chats")) {
            if savedChats.chats.isEmpty {
                Text("No saved chats. Start a new chat above.")
            } else {
                ForEach(savedChats.chats.sorted(by: { $0.date < $1.date }).reversed()) { chat in
                    NavigationLink {
                        SavedChatView(chat: chat)
                    } label: {
                        SavedChatLabel(chat: chat, showingDeleteAlert: $showingDeleteAlert)
                    }
                    .alert(isPresented: $showingDeleteAlert, content: {
                        Alert(title: deleteAlertTitle,
                              primaryButton: .destructive(
                                Text("Undo"),
                                action: {
                                    savedChats.undoDelete()
                                }
                              ),
                              secondaryButton: .default(Text("OK"))
                        )
                    })
                    .contextMenu {
                        Button {
                            savedChats.toggleFavorite(chat)
                        } label: {
                            if chat.isFavorite {
                                Label("Unmark as favorite", systemImage: "seal")
                            } else {
                                Label("Mark as Favorite", systemImage: "checkmark.seal")
                            }
                        }
                        
                        Button(role: .destructive) {
                            savedChats.delete(chat)
                            showingDeleteAlert = true
                        } label: {
                            Label("Delete chat", systemImage: "trash")
                        }
                    }
                    .swipeActions {
                        Button {
                            savedChats.delete(chat)
                            showingDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }.tint(.red)
                    }
                    .swipeActions(edge: .leading) {
                        
                        Button {
                            savedChats.toggleFavorite(chat)
                        } label: {
                            if chat.isFavorite {
                                Label("Unmark as favorite", systemImage: "seal")
                            } else {
                                Label("Mark as Favorite", systemImage: "checkmark.seal")
                            }
                        }
                        .tint(chat.isFavorite ? .blue : .yellow)
                    }
                }
            }
        }
    }
}
    
extension ContentView {
    private var chatGPTEngineSection: some View {
        
        // ChatGPT Engines
        // NavigationLink will push to a corresponding ChatView
        Section(header: Text("ChatGPT Engines"))  {
            NavigationLink {
                ChatView(viewModel: davinciVM, savedChats: savedChats, engine: "davinci")
            } label: {
                EngineLabelView(engine: "davinci")
            }
            
            NavigationLink {
                ChatView(viewModel: curieVM, savedChats: savedChats, engine: "curie")
            } label: {
                EngineLabelView(engine: "curie")
            }
            
            NavigationLink {
                ChatView(viewModel: babbageVM, savedChats: savedChats, engine: "babbage")
            } label: {
                EngineLabelView(engine: "babbage")
            }
            
            NavigationLink {
                ChatView(viewModel: adaVM, savedChats: savedChats, engine: "ada")
            } label: {
                EngineLabelView(engine: "ada")
            }
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environmentObject(SavedChats())
        }
    }
