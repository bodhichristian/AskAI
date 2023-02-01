//
//  SavedChatView.swift
//  OpenAIProject
//
//  Created by christian on 1/28/23.
//

import SwiftUI

struct SavedChatView: View {
    @State var chat: Chat
    
    private var chatColor: Color {
        switch chat.engine {
        case "davinci": return .mint
        case "curie": return .purple
        case "babbage": return .green
        default: return Color(red: 3, green: 0.2, blue: 0.6)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CircleImage(engine: chat.engine, width: 150, height: 150)
                        .padding(8)
                        .padding(.top, 6)
                        .overlay {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.yellow)
                                .opacity(chat.isFavorite ? 1 : 1)
                                .offset(x: 60, y: 60)
                        }
                    ZStack {
                        HStack {
                            Text("Chat with")
                            Text(chat.engine.capitalizeFirst())
                                .foregroundColor(chatColor)
                        }
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        
                        HStack {
                            
                            
                        }
                    }
                    VStack(alignment: .leading) {
                        // request block
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
                        
                        // response block
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(chat.response)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(chatColor.opacity(0.2))
                                    )
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle(Text(chat.date, format: .dateTime.month().day().year()))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct SavedChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SavedChatView(chat: Chat.example)
        }
    }
}


