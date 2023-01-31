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
                        Text("You haven't saved any chats yet.")
                    } else {
                        ForEach(savedChats.chats.reversed()) { chat in
                            NavigationLink {
                                SavedChatView(chat: chat)
                            } label: {
                                SavedChatLabel(chat: chat)
                            }
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
                                } label: {
                                    Label("Delete chat", systemImage: "trash")
                                }
                            }
                            .swipeActions {
                                Button {
                                    savedChats.delete(chat)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }.tint(.red)
                            }
                            .swipeActions(edge: .leading) {
                                
                                Button {
                                    savedChats.toggleFavorite(chat)
                                } label: {
                                    if chat.isFavorite {
                                        Label("Mark as Favorite", systemImage: "checkmark.seal")
                                    } else {
                                        Label("Unmark as Favorite", systemImage: "seal")
                                    }
                                }
                                .tint(chat.isFavorite ? .yellow : .blue)
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
