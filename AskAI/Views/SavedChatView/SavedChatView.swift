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
    
    @State private var dragAmount = CGSize.zero
    
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
                }
                .padding(.horizontal)
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
}

struct SavedChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedChatView(chat: Chat.example, engine: Engine.davinci)
        }
    }
}


