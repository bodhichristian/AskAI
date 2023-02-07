//
//  RequestView.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import SwiftUI

struct RequestView: View {
    @ObservedObject var viewModel: ChatViewModel
    @FocusState private var isEditing: Bool
    let engine: ChatEngine
    
    var body: some View {
        VStack{
            TextEditor(text: $viewModel.request)
                .frame(height: 100)
                .cornerRadius(10)
                .shadow(color: .secondary.opacity(0.5), radius: 8, y: 0)
                .padding(.bottom, 8)
                .overlay {
                    withAnimation {
                        Text("Ask \(engine.name.capitalizeFirst())")
                            .opacity(isEditing || !viewModel.request.isEmpty ? 0 : 1)
                            .offset(y: -8)
                            .foregroundColor(engine.color)
                            .fontWeight(.semibold)
                    }
                }.focused($isEditing)
                .disabled(viewModel.inProgress || viewModel.complete)
                .foregroundColor(viewModel.inProgress || viewModel.complete ? .gray : .primary)
            Text("Not sure what to prompt? Try \"Write me a song\" or \"Explain Quantum Mechanics like I'm five years old.\"")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .italic()
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static let viewModel = ChatViewModel.example
    static var previews: some View {
        RequestView(viewModel: viewModel, engine: .davinci)
    }
}
