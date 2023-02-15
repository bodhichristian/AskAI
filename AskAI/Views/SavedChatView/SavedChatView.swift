//
//  SavedChatView.swift
//  OpenAIProject
//
//  Created by christian on 1/28/23.
//

import SwiftUI

struct SavedChatView: View {
    let chat: Chat
    let engine: Engine
    
    let imageSaver = ImageSaver()
    
    @State private var dragAmount = CGSize.zero
    
    @State private var showingSaveSuccess = false
    @State private var showingSaveError = false
    
    @State private var successMessage = "Image saved to Photos."
    @State private var errorMessage = "There was an error saving the image. Please verify, in Settings, this app has permission to save to Photos."
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    engineImage
                    chatTitle
                    Divider()
                        .padding(.top, -4)
                    requestMessage
                    responseMessage
                        .contextMenu {
                            
                            // Context Menu presented after a press-and-hold gesture
                            // User may toggle favorite status or detele chat
                            
                            // Mark/Unmark as favorite
                            Button {
                                // Save image to Photos
                                saveImage()
                            } label: {
                                Label("Save to Photos", systemImage: "photo.on.rectangle")
                            }
                        }
                        .disabled(chat.engine != .DALLE)
                }
                .padding(.horizontal)
            }
            .alert("Save Complete", isPresented: $showingSaveSuccess) {
                Button("OK") {}
            } message: {
                Text(successMessage)
            }
            .alert("Error", isPresented: $showingSaveError) {
                Button("OK") {}
            } message: {
                Text(errorMessage)
            }
        }
        .navigationTitle(Text(chat.date, format: .dateTime.month().day().year()))
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension SavedChatView {
    // Engine Image
    // Draggable image and conditional favorite badge
    private var engineImage: some View {
        // ChatGPT Engine logo
        // Conditionally visible 'favorite' checkmark
        // Image is draggable, and resets on release
        CircleImage(imageName: engine.name, width: 150, height: 150)
            .padding(8)
            .padding(.top, 6)
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
            SavedChatView(chat: Chat.dallEExample,engine: .DALLE)
        }
    }
}


