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
            // Engine-colored response block
            ResponseView(viewModel: viewModel, engine: engine)
            
            // TextEditor for typing a reqest
            RequestView(viewModel: viewModel, engine: engine)
            
            // Animating Progress Button: Submit, In Progress..., Response Received
            ProgressButton(viewModel: viewModel, totalRequests: totalRequests,  engine: engine)
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
        NavigationView{
            ChatGPTPromptView(viewModel: viewModel, totalRequests: TotalRequests(), engine: .davinci)
                .environmentObject(SavedChats())
        }
    }
}
