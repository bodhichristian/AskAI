//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/12/23.
//

import SwiftUI
import OpenAISwift

struct ChatGPTView: View {
    @ObservedObject var viewModel: ChatViewModel
    @ObservedObject var savedChats: SavedChats
    
    @State var engine: String
    
    var body: some View {
        
            VStack {
                ResponseView(viewModel: viewModel, savedChats: savedChats)
                
                Section {
                    RequestView(viewModel: viewModel)
                } header: {
                    Text("Chat with Artificial Intelligence.")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                HStack {
                    Button {
                        viewModel.isLoading = true
                        viewModel.firstRequest = false
                        Task {
                            await viewModel.submitRequest(viewModel.request, engine: engine)
                        }
                    } label: {
                        Label("Submit", systemImage: "terminal")
                            .fontWeight(.semibold)
                            .padding(4)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.request.isEmpty || !viewModel.response.isEmpty || viewModel.isLoading)
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis.bubble.fill")
                        .resizable()
                        .frame(width: 34, height: 30)
                        .foregroundColor(viewModel.request.isEmpty ? .secondary : .blue)
                        .opacity(!viewModel.request.isEmpty || viewModel.isLoading ? 1 : 0)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.arrow.down")
                        .resizable()
                        .frame(width: 40, height: 30)
                        .foregroundColor(.yellow)
                        .opacity(viewModel.isLoading ? 1 : 0)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.seal")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor( .green)
                        .opacity(viewModel.request.isEmpty || viewModel.response.isEmpty ? 0 : 1)
                    
                    Spacer()
                }
            }
            .padding(8)
            .navigationTitle("Ask ChatGPT")
        }
    }


struct ChatGPTView_Previews: PreviewProvider {
    static let viewModel = ChatViewModel.example
    
    static var previews: some View {
        ChatGPTView(viewModel: viewModel, savedChats: SavedChats(), engine: "davinci")
    }
}
