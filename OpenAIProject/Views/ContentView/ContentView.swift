//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var savedChats = SavedChats()
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
                    
                    NavigationLink {
                        ChatGPTView(viewModel: viewModel, savedChats: savedChats)

                    } label: {
                        Label {
                            Text("Ask Stable Diffusion (Coming soon)")
                        } icon: {
                            ZStack {
                                Circle()
                                    .frame(width: 30)
                                    .foregroundColor(.white)
                                    .shadow(color: .secondary, radius: 2)
                                Image("StabilityAI")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(-4)
                            }
                           
                        }
                    }
                }
                
                Section(header: Text("Saved Chats")) {
                    ForEach(savedChats.chats) { chat in
                        NavigationLink {
                            VStack {
                                Text(chat.request)
                                Text(chat.response)
                            }
                        } label: {
                            SavedAskLabel(request: chat.request, response: chat.response, image: "ChatGPT", date: chat.date)
                            }
                        }
                }
            }
            .font(.subheadline)
            .navigationTitle("AskAI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
