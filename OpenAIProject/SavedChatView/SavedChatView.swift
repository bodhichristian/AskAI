//
//  SavedChatView.swift
//  OpenAIProject
//
//  Created by christian on 1/28/23.
//

import SwiftUI

struct SavedChatView: View {
    @State var chat: Chat
    
    private var accentColor: Color {
        switch chat.engine {
        case "davinci": return .mint
        case "curie": return .purple
        case "babbage": return .green
        default: return Color(red: 3, green: 0.2, blue: 0.6)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CircleImage(engine: chat.engine, width: 150, height: 150)
                    .padding(8)
                    .padding(.top, 6)
                ZStack {
                    HStack {
                        Text("Chat with")
                        Text(chat.engine.capitalizeFirst())
                            .foregroundColor(accentColor)
                        
                            
                    }
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.yellow)
                            .opacity(chat.isFavorite ? 1 : 0)
                            .offset(x: -20)
                    }
                    
                }
                VStack(alignment: .leading) {
                    // request block
                    VStack(alignment: .trailing, spacing: 4) {
                        HStack(spacing: 8) {
    //                        Image(systemName: "person.circle")
    //                            .resizable()
    //                            .frame(width: 30, height: 30)
    //                            .foregroundColor(.blue)
    //                        Text("Request")
    //                            .font(.title2)
                            Spacer()
                        }
                        Text(chat.request)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.ultraThinMaterial)
                            )
                    }

                    // response block
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Spacer()
    //                        Text("\(chat.engine.capitalizeFirst())")
    //                            .font(.title3)
    //                            .offset(x: 35)
                            //CircleImage(engine: chat.engine, width: 30, height: 30)
                        }
                        Text(chat.response)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(accentColor.opacity(0.5))
                            )
                    }
                }
                .padding(.horizontal)
            .navigationTitle(Text(chat.date, format: .dateTime.month().day().year()))
            }
        }
        
    }
    
}

struct SavedChatView_Previews: PreviewProvider {
    static var previews: some View {
        SavedChatView(chat: Chat.example)
    }
}
