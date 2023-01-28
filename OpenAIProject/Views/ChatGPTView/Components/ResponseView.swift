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
    
    private var accentColor: Color {
        switch engine {
        case "davinci": return .mint
        case "curie": return .purple
        case "babbage": return .green
        default: return Color(red: 3, green: 0.2, blue: 0.6)
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(accentColor).opacity(0.5)
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
                // sets request and response to empty strings
                // sets isLoading to false so any bound views animate accordingly
                // disabled if request is an empty string
                Button {
                    withAnimation(.linear(duration: 0.1)) {
                        viewModel.request = ""
                        viewModel.response = ""
                        viewModel.isLoading = false
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
                
                // checkmark button
                Button {
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
