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
                Section(header: Text("ChatGPT Engines"))  {
                    NavigationLink {
                        ChatGPTView(viewModel: viewModel, savedChats: savedChats, engine: "davinci")
                    } label: {
                        Label {
                            VStack(alignment: .leading) {
                                Text("Ask DaVinci")
                                    .font(.headline)
                                Text("Most capable")
                                    .font(.caption)
                                    .italic()
                                    .foregroundColor(.mint)
                            }
                            .padding(.leading, 45)
                        } icon: {
                                Image("davinci")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.white, lineWidth: 0.8))
                                    .shadow(color: .secondary, radius: 7)
                                    .padding(.leading, 35)
                        }
                    }
                    
                    NavigationLink {
                        ChatGPTView(viewModel: viewModel, savedChats: savedChats, engine: "curie")
                    } label: {
                        Label {
                            VStack(alignment: .leading) {
                                Text("Ask Curie")
                                    .font(.headline)
                                Text("Powerful, yet fast")
                                    .font(.caption)
                                    .italic()
                                    .foregroundColor(.purple)
                            }
                            .padding(.leading, 45)
                        } icon: {
                                Image("curie")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.white, lineWidth: 0.8))
                                    .shadow(color: .secondary, radius: 7)
                                    .padding(.leading, 35)
                        }
                    }
                    NavigationLink {
                        ChatGPTView(viewModel: viewModel, savedChats: savedChats, engine: "babbage")
                    } label: {
                        Label {
                            VStack(alignment: .leading) {
                                Text("Ask Babbage")
                                    .font(.headline)
                                Text("Straightforward tasks")
                                    .font(.caption)
                                    .italic()
                                    .foregroundColor(.green)
                            }
                            .padding(.leading, 45)
                        } icon: {
                                Image("babbage")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.white, lineWidth: 0.8))
                                    .shadow(color: .secondary, radius: 7)
                                    .padding(.leading, 35)
                        }
                    }
                    NavigationLink {
                        ChatGPTView(viewModel: viewModel, savedChats: savedChats, engine: "ada")
                    } label: {
                        Label {
                            VStack(alignment: .leading) {
                                Text("Ask Ada")
                                    .font(.headline)
                                Text("Fast and simple")
                                    .font(.caption)
                                    .italic()
                                    .foregroundColor(Color(red: 3, green: 0.2, blue: 0.6))
                            }
                            .padding(.leading, 45)
                        } icon: {
                                Image("ada")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.white, lineWidth: 0.8))
                                    .shadow(color: .secondary, radius: 7)
                                    .padding(.leading, 35)
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
                        ForEach(savedChats.chats.reversed()) { chat in
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
