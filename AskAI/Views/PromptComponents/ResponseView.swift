//
//  ResponseView.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import SwiftUI

struct ResponseView: View {
    @ObservedObject var viewModel: OpenAIViewModel
    @EnvironmentObject var savedChats: SavedChats
    
    let engine: Engine
    
    // Provides user context for expected return media
    var defaultWillAppearMessage: String {
        switch engine {
        case .DALLE: return "Image will appear here."
        default: return "Response will appear here."
        }
    }
    
    // Alert titles and messages
    @State private var showingDeleteAlert = false
    @State private var deleteAlertTitle = Text("Clear Chat")
    @State private var deleteAlertMessage = Text("Are you sure you want to delete this chat?")
    
    @State private var showingSaveAlert = false
    @State private var saveAlertTitle = Text("Chat saved.")
    @State private var saveAlertMessage = Text("View in Saved Chats")
    
    // chatSaved is used to determine whether to prompt user with delete alert
    // If user has saved the current chat, they may clear it without warning
    @State private var chatSaved = false
    
    //@State private var generatedImage: UIImage?
    
    var body: some View {
        responseBlock
            .overlay {
                clearAndSaveButtons
                    .environmentObject(savedChats)

            }
    }
}

extension ResponseView {
    private var responseBlock: some View {
        ZStack(alignment: engine == .DALLE ? .center : .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(engine.color).opacity(0.5)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
                .overlay {
                    if viewModel.response == "" &&
                        viewModel.generatedImage == nil {
                        // default text if response has no value
                        Text(defaultWillAppearMessage)
                    }
                    if let generatedImage = viewModel.generatedImage {
                        Image(uiImage: generatedImage)
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fill)
                        
                    } else {
                        ScrollView {
                            Text(viewModel.response)
                                .padding()
                        }
                    }
                }
                .cornerRadius(10)
                .shadow(color: .secondary.opacity(0.5), radius: 8, y: 0)
        }
    }
    
    private var clearAndSaveButtons: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(.clear)
            VStack(spacing: 8) {
                
                // Trash Button - Clear Chat
                Button {
                    if chatSaved {
                        withAnimation{
                            viewModel.request = ""
                            viewModel.response = ""
                            viewModel.inProgress = false
                            viewModel.complete = false
                            viewModel.generatedImage = nil
                            chatSaved = false
                        }
                    } else {
                        showingDeleteAlert = true
                    }
                } label : {
                    ZStack {
                        Circle()
                            .frame(width: 40)
                            .foregroundColor((viewModel.response.isEmpty && viewModel.generatedImage == nil)
                                             ? .secondary.opacity(0.2)
                                             : .red.opacity(0.7)
                            )
                            .offset(y: 5)
                        Image(systemName: "trash")
                            .offset(y: 5)
                            .foregroundColor((viewModel.response.isEmpty && viewModel.generatedImage == nil)
                                             ? .white.opacity(0.6)
                                             : .white
                            )
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
                                viewModel.generatedImage = nil
                            }
                        }))
                })
                
                // Checkmark Button - Save Chat
                Button {
                    showingSaveAlert = true
                    let chat = Chat(request: viewModel.request, response: viewModel.response, engine: engine, generatedImage: viewModel.generatedImage)
                    savedChats.add(chat)
                } label : {
                    ZStack {
                        Circle()
                            .frame(width: 40)
                            .foregroundColor((viewModel.response.isEmpty && viewModel.generatedImage == nil)
                                             ? .secondary.opacity(0.2)
                                             : .green.opacity(0.7)
                            )
                            .padding(4)
                        Image(systemName: "checkmark")
                            .foregroundColor((viewModel.response.isEmpty && viewModel.generatedImage == nil)
                                             ? .white.opacity(0.6)
                                             : .white
                            )
                    }
                }
                .disabled(viewModel.response.isEmpty && viewModel.generatedImage == nil)
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
    
    static var previews: some View {
        ResponseView(viewModel: OpenAIViewModel(generatedImage: UIImage(named: "twitter")), engine: .DALLE)
            .environmentObject(SavedChats())
    }
}
