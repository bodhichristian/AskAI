//
//  DALLEView.swift
//  OpenAIProject
//
//  Created by christian on 2/7/23.
//

import SwiftUI
import OpenAISwift

struct DALLEPromptView: View {
    @ObservedObject var viewModel: OpenAIViewModel
    @ObservedObject var totalRequests: TotalRequests
    @EnvironmentObject var dallESavedChats: SavedChats
    
    let engine: Engine
    
    var body: some View {
        VStack {
            // Engine-colored response block
            ResponseView(viewModel: viewModel, engine: engine)
                .environmentObject(dallESavedChats)
            
            // TextEditor for typing a reqest
            RequestView(viewModel: viewModel, engine: engine)
            
            // Animating Progress Button: Submit, In Progress..., Response Received
            ProgressButton(viewModel: viewModel, totalRequests: totalRequests, engine: engine)
        }
        .padding(8)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Ask DALL-E")
        .environmentObject(dallESavedChats)
    }
}

struct DALLEView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DALLEPromptView(viewModel: OpenAIViewModel.example, totalRequests: TotalRequests(), engine: .DALLE)
                .environmentObject(SavedChats())
        }
    }
}
