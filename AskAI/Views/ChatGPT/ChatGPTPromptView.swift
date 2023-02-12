//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/12/23.
//

import SwiftUI
import OpenAISwift

struct ChatGPTPromptView: View {
    @ObservedObject var viewModel: OpenAIViewModel
    @EnvironmentObject var chatGPTSavedChats: SavedChats
    @ObservedObject var totalRequests: TotalRequests
    
    let engine: Engine
    
    var body: some View {
        VStack {
            ResponseView(viewModel: viewModel, engine: engine)
            
            Section {
                RequestView(viewModel: viewModel, engine: engine)
            } header: {
                Text("Chat with Artificial Intelligence.")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding(2)
            }
            
            ProgressButton(viewModel: viewModel, totalRequests: totalRequests,  engine: engine)
                .padding(.vertical, -50)
        }
        .padding(8)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Ask \(engine.name.capitalizeFirst())")
        .environmentObject(chatGPTSavedChats)
    }
}

struct ChatView_Previews: PreviewProvider {
    static let viewModel = OpenAIViewModel.example
    
    static var previews: some View {
        ChatGPTPromptView(viewModel: viewModel, totalRequests: TotalRequests(), engine: .davinci)
            .environmentObject(SavedChats())
    }
}
