//
//  SavedAskLabel.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct SavedChatLabel: View {
    @ObservedObject var chat: Chat
    
    let formatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(chat.request)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                    .lineLimit(1)
                
            }
            
            HStack(alignment: .center) {
                Text(chat.date, format: .dateTime.month().day().year())
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.yellow)
                    .opacity(chat.isFavorite ? 1 : 0)
            }
            
            HStack(alignment: .center) {
                ZStack {
                    Circle()
                        .frame(width: 30)
                        .foregroundColor(.white)
                        .shadow(color: .secondary, radius: 2)
                    Image(chat.image)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                
                Text(chat.response.trimmingCharacters(in: .whitespacesAndNewlines))
                    .font(.caption)
                //.italic()
                    .lineLimit(2)
                
                
            }
        }
    }
    
}

struct SavedAskLabel_Previews: PreviewProvider {
    static var previews: some View {
        SavedChatLabel(chat: Chat.example)
    }
}
