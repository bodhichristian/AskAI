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
    var willAppearHereMessage: String {
        switch engine {
        case .DALLE: return "Image will appear here."
        default: return "Response will appear here."
        }
    }
    
    // ALERT TITLES AND MESSAGES
    // Delete Alert
    @State private var showingDeleteAlert = false
    // Title
    @State private var deleteAlertTitle = Text("Clear Chat")
    // Message
    var deleteAlertMessage: Text {
        switch engine {
        case .DALLE: return Text("Are you sure you want to delete this image? This cannot be undone.")
        default: return Text("Are you sure you want to delete this chat? This cannot be undone.")
        }
    }
    
    // Save Alert
    @State private var showingSaveAlert = false
    // Title
    private var saveAlertTitle: Text {
        switch engine {
        case .DALLE: return Text("Image saved")
        default: return Text("Chat saved")
        }
    }
    // Message
    private var saveAlertMessage: Text {
        switch engine {
        case .DALLE: return Text("View in Saved Images")
        default: return Text("View in Saved Chats")
        }
    }
 
    var body: some View {
        responseBlock
            .overlay {
                clearAndSaveButtons
                    .environmentObject(savedChats)
            }
    }
}

extension ResponseView {
    // Response Block
    // Response/Image will appear here
    private var responseBlock: some View {
        ZStack(alignment: engine == .DALLE ? .center : .topLeading) {
            // Engine-colored rounded rectangle
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(engine.color).opacity(0.5)
            // UltraThinMaterial overlay
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.ultraThinMaterial)
                .overlay {
                    // If no response has yet been yielded
                    if viewModel.response == "" &&
                        viewModel.generatedImage == nil {
                        // Provide default message
                        Text(willAppearHereMessage)
                    }
                    // If an image has been returned
                    if let generatedImage = viewModel.generatedImage {
                        Image(uiImage: generatedImage)
                            .resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fill)
                    // If text has been returned
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
    
    // Clear(red trash) and Save(green checkmark) buttons
    // Aligned to bottom trailing corner of container
    private var clearAndSaveButtons: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .foregroundColor(.clear)
            VStack(spacing: 8) {
                
                // Trash Button - Clear Chat
                Button {
                    showingDeleteAlert = true
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
                    let chat = Chat(request: viewModel.request, response: viewModel.response, engine: engine, generatedImage: viewModel.generatedImage?.pngData())
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
                                viewModel.request = ""
                                viewModel.response = ""
                                viewModel.inProgress = false
                                viewModel.complete = false
                                viewModel.generatedImage = nil
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
