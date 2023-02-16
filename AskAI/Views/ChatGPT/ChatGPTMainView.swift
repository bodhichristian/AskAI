//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct ChatGPTMainView: View {
    @ObservedObject var totalRequests: TotalRequests
    @ObservedObject var savedChats: SavedChats
    
    // Returns an array of saved, text-based chats
    var filteredChats: [Chat] {
        savedChats.chats.filter { chat in
            return chat.engine != .DALLE
        }
    }
    
    // One ChatViewModel is instantiated for each of the available chat engines as a State Object, keeping interactions with engines separate
    @StateObject var davinciVM = OpenAIViewModel()
    @StateObject var curieVM = OpenAIViewModel()
    @StateObject var babbageVM = OpenAIViewModel()
    @StateObject var adaVM = OpenAIViewModel()
    
    // When showingDeleteAlert is toggled, an alert is presented to confirm action
    @State private var showingDeleteAlert = false
    @State private var deleteAlertTitle = Text("Chat deleted.")
    
    // When showingInfoView is toggled, a modal sheet will present
    @State private var showingInfoView = false

    var body: some View {
        NavigationView {
            List {
                chatGPTEngineSection
                savedChatSection
            }
            .navigationTitle("Ask ChatGPT")
            .toolbar {
                Button {
                    showingInfoView.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            .sheet(isPresented: $showingInfoView) {
                ChatGPTInfoView()
            }
        }
        .environmentObject(savedChats)
    }
}

extension ChatGPTMainView {
    // Chat GPT Engine List Section
    private var chatGPTEngineSection: some View {

        // NavigationLink will push to a corresponding ChatView
        Section(header: Text("ChatGPT Engines"))  {
            NavigationLink {
                ChatGPTPromptView(viewModel: davinciVM, totalRequests: totalRequests, engine: .davinci)
            } label: {
                EngineLabelView(engine: .davinci)
            }
            
            NavigationLink {
                ChatGPTPromptView(viewModel: curieVM, totalRequests: totalRequests, engine: .curie)
            } label: {
                EngineLabelView(engine: .curie)
            }
            
            NavigationLink {
                ChatGPTPromptView(viewModel: babbageVM, totalRequests: totalRequests, engine: .babbage)
            } label: {
                EngineLabelView(engine: .babbage)
            }
            
            NavigationLink {
                ChatGPTPromptView(viewModel: adaVM, totalRequests: totalRequests, engine: .ada)
            } label: {
                EngineLabelView(engine: .ada)
            }
        }
    }
    
    // Saved Chat Section
    private var savedChatSection: some View {

    // If user has chats saved, they will display as a list of NavigationLinks
    // A default message is presented if there are no saved chats
    // Each SavedChatLabel pushes to a SavedChatView
    Section(header: Text("Saved Chats")) {
        if filteredChats.isEmpty {
            Text("Start a new chat above. Saved chats will appear here.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding()
                .offset(x: 7)
        } else {
            ForEach(filteredChats.sorted(by: { $0.date < $1.date }).reversed()) { chat in
                NavigationLink {
                    SavedChatView(chat: chat, savedChats: savedChats, engine: chat.engine)
                } label: {
                    SavedChatLabel(chat: chat, showingDeleteAlert: $showingDeleteAlert, engine: chat.engine)
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
                    
                    // Context Menu presented after a press-and-hold gesture
                    // User may toggle favorite status or detele chat
                    
                    // Mark/Unmark as favorite
                    Button {
                        savedChats.toggleFavorite(chat)
                    } label: {
                        if chat.isFavorite {
                            Label("Unmark as favorite", systemImage: "seal")
                        } else {
                            Label("Mark as Favorite", systemImage: "checkmark.seal")
                        }
                    }
                    
                    // Delete Chat
                    Button(role: .destructive) {
                        savedChats.delete(chat)
                        showingDeleteAlert = true
                    } label: {
                        Label("Delete chat", systemImage: "trash")
                    }
                }
                .swipeActions(edge: .leading) {
                    
                    // Swiping from leading edge reveals a favorite toggle
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
                .swipeActions {
                    
                    // Swiping from the trailing edge reveals a delete button
                    Button {
                        savedChats.delete(chat)
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
        ChatGPTMainView(totalRequests: TotalRequests(), savedChats: SavedChats())
    }
}
