//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var savedChats: SavedChats
    @StateObject var davinciVM = ChatViewModel(request: "", response: "", isLoading: false, firstRequest: true)
    @StateObject var curieVM = ChatViewModel(request: "", response: "", isLoading: false, firstRequest: true)
    @StateObject var babbageVM = ChatViewModel(request: "", response: "", isLoading: false, firstRequest: true)
    @StateObject var adaVM = ChatViewModel(request: "", response: "", isLoading: false, firstRequest: true)
    
    @State private var isShowingMenu = false
    
    @State private var showingDeleteAlert = false
    @State private var deleteAlertTitle = Text("Chat deleted.")
    //@State private var deleteAlertMessage = Text("Permanently delete this chat. This action cannot be undone.")
    
    var body: some View {
        NavigationView {
            List {
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
            
            .font(.subheadline)
            .navigationTitle("AskAI")
            .toolbar {
                Button {
                    isShowingMenu.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            .sheet(isPresented: $isShowingMenu) {
                InfoView()
            }
        }
        .environmentObject(savedChats)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SavedChats())
    }
}
