//
//  SavedChatView.swift
//  OpenAIProject
//
//  Created by christian on 1/28/23.
//

import SwiftUI

struct SavedChatView: View {
    @ObservedObject var chat: Chat
    @ObservedObject var savedChats: SavedChats
    let engine: Engine
    
    let imageSaver = ImageSaver()
    
    @State private var dragAmount = CGSize.zero
    
    @State private var showingSaveSuccess = false
    @State private var showingSaveError = false
    
    @State private var successMessage = "Image saved to Photos."
    @State private var errorMessage = "There was an error saving the image. Please verify, in Settings, this app has permission to save to Photos."
    
    // ALERT TITLES AND MESSAGES
    
    // Delete Alert
    // Alert Title
    @State private var showingDeleteAlert = false
    var deleteAlertTitle: Text {
        switch engine {
        case .DALLE: return Text("Delete Image")
        default: return Text("Delete Chat")
        }
    }
    // Alert Message
    var deleteAlertMessage: Text {
        switch engine {
        case .DALLE: return Text("Are you sure you want to delete this image? This action cannot be undone.")
        default: return Text("Are you sure you want to delete this chat? This cannot be undone.")
        }
    }
    
    @State private var saveComplete = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Chat Header
                    engineImage
                    chatTitle
                    Divider()
                        .padding(.bottom)
                    
                    // Action Buttons
                    chatActions
                    Divider()
                        .padding(.top, -4)
                    
                    // Chat Detail
                    requestMessage
                    responseMessage
                }
                .padding(.horizontal)
            }
            // Save Image Completion Alert
            .alert("Save Complete", isPresented: $showingSaveSuccess) {
                Button("OK") {
                    withAnimation(.easeIn(duration: 0.1)) {
                        saveComplete = true
                    }
                }
            } message: {
                Text(successMessage)
            }
            // Save Image Error Alert
            .alert("Error", isPresented: $showingSaveError) {
                Button("OK") {}
            } message: {
                Text(errorMessage)
            }
            // Delete Chat Error Alert
            .alert(isPresented: $showingDeleteAlert, content: {
                Alert(
                    title: deleteAlertTitle,
                    message: deleteAlertMessage,
                    primaryButton: .default(Text("Cancel")),
                    secondaryButton: .destructive(Text("Delete"), action:  {
                        savedChats.delete(chat)
                    }
                                                 ))
            })
        }
        .navigationTitle(Text(chat.date, format: .dateTime.month().day().year()))
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension SavedChatView {
    // Engine Image
    // Draggable image and conditional favorite badge
    // Image is draggable, and resets on release
    private var engineImage: some View {
        CircleImage(imageName: engine.name, width: 150, height: 150)
            .padding(8)
            .padding(.top, 10)
            .overlay {
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.yellow)
                    .opacity(chat.isFavorite ? 1 : 0)
                    .offset(x: 60, y: 60)
            }
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        dragAmount = gesture.translation
                    }
                    .onEnded { _ in
                        dragAmount = .zero
                    }
            )
            .animation(.spring(), value: dragAmount)
    }
    
    // Chat Title
    // "Chat with <Engine Name>
    private var chatTitle: some View {
        HStack {
            Text("Chat with")
            Text(engine == .DALLE
                 ? "DALL·E"
                 : engine.name.capitalizeFirst())
            .foregroundColor(engine.color)
        }
        .font(.largeTitle)
        .fontWeight(.medium)
    }
    
    // Toolbar
    // Save, Favorite/Unmark, Delete buttons
    private var chatActions: some View {
        HStack {
            if chat.engine == .DALLE{
                Button {
                    saveImage()
                } label: {
                    Label(title: {
                        Text("Save")
                            .foregroundColor(.primary)
                    }, icon: {
                        Image(systemName: saveComplete
                              ? "square.and.arrow.down.fill"
                              : "square.and.arrow.down")
                        .renderingMode(.template)
                        .foregroundColor(.blue)
                    } )
                    .padding(5)
                }
                .buttonStyle(.borderedProminent)
                .tint(.secondary.opacity(0.1))
                Spacer()
                
            }
            Button {
                chat.isFavorite.toggle()
            } label: {
                Label(title: {
                    Text(chat.isFavorite
                         ? "Unmark"
                         : "Favorite")
                    .foregroundColor(.primary)
                }, icon: {
                    Image(systemName: chat.isFavorite
                          ? "checkmark.seal"
                          : "checkmark.seal.fill")
                    .renderingMode(.template)
                    .foregroundColor(.yellow)
                    
                } )
                .padding(5)
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.secondary.opacity(0.1))
            if chat.engine == .DALLE {
                Spacer()
            }
            
            Button {
                showingDeleteAlert = true
            } label: {
                Label(title: {
                    Text("Delete")
                        .foregroundColor(.primary)
                }, icon: {
                    Image(systemName: "trash")
                        .renderingMode(.template)
                        .foregroundColor(.red)
                } )
                .padding(5)
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.secondary.opacity(0.1))
        }
        .padding(.top, -20)
        .padding(.vertical, 10)
    }
    
    // Request text
    private var requestMessage: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .trailing, spacing: 4) {
                HStack(spacing: 8) {
                    Spacer()
                    
                    Text(chat.request.trimmingCharacters(in: .whitespacesAndNewlines))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.ultraThinMaterial)
                        )
                }
            }
        }
    }
    
    // Response text
    private var responseMessage: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                if chat.generatedImage != nil {
                    Image(uiImage: UIImage(data: chat.generatedImage!)!)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 7)
                        .padding()
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.ultraThinMaterial)
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(engine.color.opacity(0.2))
                            }
                        )
                    Spacer()
                }
                else {
                    Text(chat.response)
                        .padding()
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.ultraThinMaterial)
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(engine.color.opacity(0.2))
                            }
                        )
                    Spacer()
                }
            }
        }
    }
    
    // Save image to Photos
    private func saveImage() {
        
        // Ensure image data exists
        guard let imageData = chat.generatedImage else { return }
        
        // On success, an alert will present
        imageSaver.successHandler = {
            showingSaveSuccess = true
        }
        
        // On error, an alert will present
        imageSaver.errorHandler = { _ in
            showingSaveError = true
        }
        
        // Write image to Photos
        imageSaver.writeToPhotoAlbum(image: UIImage(data: imageData)!)
    }
}

struct SavedChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedChatView(chat: Chat.dallEExample, savedChats: SavedChats(),engine: .DALLE)
        }
    }
}


