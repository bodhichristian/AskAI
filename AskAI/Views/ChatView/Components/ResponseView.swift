//
//  ResponseView.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import SwiftUI

struct ResponseView: View {
    @ObservedObject var viewModel: ChatViewModel
    @ObservedObject var savedChats: SavedChats
    @State var engine: String
    
    private var chatColor: Color {
        switch engine {
        case "davinci": return .mint
        case "curie": return .purple
        case "babbage": return .green
        default: return Color(red: 3, green: 0.2, blue: 0.6)
        }
    }
    
    @State private var showingDeleteAlert = false
    @State private var deleteAlertTitle = Text("Clear Chat")
    @State private var deleteAlertMessage = Text("Are you sure you want to delete this chat?")
    @State private var showingSaveAlert = false
    @State private var saveAlertTitle = Text("Chat saved.")
    @State private var saveAlertMessage = Text("View in Saved Chats")
    
    @State private var chatSaved = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(chatColor).opacity(0.5)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
                .overlay {
                    if viewModel.response == "" {
                        // default text if there is no response
                        Text("Response will appear here.")
                    }
                }
            ScrollView {
                Text(viewModel.response)
                    .padding()
            }
        }
        
        
        .shadow(color: .secondary.opacity(0.5), radius: 8, y: 0)

        .overlay {
            // clear and save buttons
            buttonStack
        }
    }
}

extension ResponseView {
    
    private var buttonStack: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(.clear)
            VStack(spacing: 8) {
                // TRASH CAN BUTTON
                Button {
                    if chatSaved {
                        withAnimation{
                            viewModel.request = ""
                            viewModel.response = ""
                            viewModel.inProgress = false
                            viewModel.complete = false
                            chatSaved = false
                        }
                    } else {
                        showingDeleteAlert = true
                    }
                } label : {
                    ZStack {
                        Circle()
                            .frame(width: 40)
                            .foregroundColor(viewModel.response.isEmpty ? .secondary.opacity(0.2) : .red.opacity(0.7))
                            .offset(y: 5)
                        Image(systemName: "trash")
                            .offset(y: 5)
                            .foregroundColor(viewModel.response.isEmpty ? .white.opacity(0.6) : .white)
                    }
                }
                .disabled(viewModel.request.isEmpty)
                .alert(isPresented: $showingDeleteAlert, content: {
                    Alert(
                        title: deleteAlertTitle,
                        message: deleteAlertMessage,
                        primaryButton: .default(Text("Don't clear")),
                        secondaryButton: .destructive(Text("Delete"), action: {
                            withAnimation{
                                viewModel.request = ""
                                viewModel.response = ""
                                viewModel.inProgress = false
                                viewModel.complete = false
                            }
                        }))
                })
                
                // checkmark button
                Button {
                    showingSaveAlert = true
                    print("tapped")
                    let chat = Chat(request: viewModel.request, response: viewModel.response, engineUsed: engine)
                    savedChats.add(chat)
                    
  
                } label : {
                    ZStack {
                        Circle()
                            .frame(width: 40)
                            .foregroundColor(viewModel.response.isEmpty ? .secondary.opacity(0.2) : .green.opacity(0.7))
                            .padding(4)
                        Image(systemName: "checkmark")
                            .foregroundColor(viewModel.response.isEmpty ? .white.opacity(0.6) : .white)
                    }
                }
                .disabled(viewModel.response.isEmpty)
                .alert(isPresented: $showingSaveAlert, content: {
                    Alert(
                        title: saveAlertTitle,
                        message: saveAlertMessage,
                        dismissButton: .default(Text("OK"), action: {
                            withAnimation{
                                chatSaved = true
                            }
                        }))
                })
            }
            .padding(4)
        }
    }
}

struct ResponseView_Previews: PreviewProvider {
    static let viewModel = ChatViewModel.example
    static var previews: some View {
        ResponseView(viewModel: viewModel, savedChats: SavedChats(), engine: "davinci")
        
    }
}
