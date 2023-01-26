//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var savedChats: SavedChats
    @StateObject var viewModel = ChatViewModel(request: "", response: "", isLoading: false, firstRequest: true)
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("AI Toolkit"))  {
                    NavigationLink {
                        ChatGPTView(viewModel: viewModel, savedChats: savedChats)
                    } label: {
                        Label {
                            Text("Ask ChatGPT")
                        } icon: {
                            ZStack {
                                Circle()
                                    .frame(width: 30)
                                    .foregroundColor(.white)
                                    .shadow(color: .secondary, radius: 2)
                                Image("ChatGPT")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
//                    NavigationLink {
//                        Text("Coming soon.")
//                    } label: {
//                        Label {
//                            Text("Ask Stable Diffusion (Coming soon)")
//                        } icon: {
//                            ZStack {
//                                Circle()
//                                    .frame(width: 30)
//                                    .foregroundColor(.white)
//                                    .shadow(color: .secondary, radius: 2)
//                                Image("StabilityAI")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .padding(-4)
//                            }
//                        }
//                    }
                }
                
                Section(header: Text("Saved Chats")) {
                    if savedChats.chats.isEmpty {
                        Text("You haven't saved any chats yet.")
                    } else {
                        ForEach(savedChats.chats) { chat in
                            NavigationLink {
                                VStack {
                                    Text(chat.request)
                                    Text(chat.response)
                                }
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
