//
//  SavedAskLabel.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct SavedChatLabel: View {
    @ObservedObject var chat: Chat
    @Binding var showingDeleteAlert: Bool
    
    let engine: Engine
    
    let formatter = DateFormatter()
        
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                // Request preview
                Text(chat.request)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                    .lineLimit(1)
            }
            // Date with conditional favorite badge
            HStack(alignment: .center) {
                // Date format: Feb 16, 2023
                Text(chat.date, format: .dateTime.month().day().year())
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                // Conditional favorite checkmark
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.yellow)
                    .opacity(chat.isFavorite ? 1 : 0)
            }
            // Engine logo and response preview
            HStack() {
                // Logo
                CircleImage(imageName: engine.name, width: 25, height: 25)
                    .padding(.leading, 35)
                // Response preview
                Text(chat.response.trimmingCharacters(in: .whitespacesAndNewlines))
                    .font(.caption)
                    .lineLimit(2)
            }
            .offset(x: -30)
        }
    }
}

struct SavedAskLabel_Previews: PreviewProvider {
    static var previews: some View {
        SavedChatLabel(chat: Chat.chatGPTExample, showingDeleteAlert: .constant(true), engine: .davinci)
    }
}
