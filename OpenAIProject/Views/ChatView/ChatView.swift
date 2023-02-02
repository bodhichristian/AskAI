//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/12/23.
//

import SwiftUI
import OpenAISwift

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    @ObservedObject var savedChats: SavedChats
    @State var engine: String
    
    var body: some View {
        
            VStack {
                ResponseView(viewModel: viewModel, savedChats: savedChats, engine: engine)
                
                Section {
                    RequestView(viewModel: viewModel, engine: engine)
                } header: {
                    Text("Chat with Artificial Intelligence.")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .padding(2)
                }
                
                //Divider()
                
                ProgressButton(viewModel: viewModel, engine: engine)
                    .padding(.vertical, -50)
            }
            .padding(8)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Ask \(engine.capitalizeFirst())")
        }
    
    }


struct ChatView_Previews: PreviewProvider {
    static let viewModel = ChatViewModel.example
    
    static var previews: some View {
        ChatView(viewModel: viewModel, savedChats: SavedChats(), engine: "davinci")
    }
}
