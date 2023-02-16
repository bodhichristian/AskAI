//
//  RequestView.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import SwiftUI

struct RequestView: View {
    @ObservedObject var viewModel: OpenAIViewModel
    @FocusState private var isEditing: Bool
    
    let engine: Engine
    
    var promptSuggestion: String {
        switch engine {
        case .DALLE: return "Not sure what to prompt? Try \"Intergalactic Ice Cream\" or \"Astronaut ninja warrior cats on the moon\""
        default: return "Not sure what to prompt? Try \"Write me a song\" or \"Explain Quantum Mechanics like I'm five years old\""
        }
    }
    
    var body: some View {
        Section {
            VStack{
                // Request
                TextEditor(text: $viewModel.request)
                    .frame(height: 100)
                    .cornerRadius(10)
                    .shadow(color: .secondary.opacity(0.5), radius: 8, y: 0)
                    .padding(.bottom, 8)
                    // Ask <Engine> overlay
                    // Opacity is 0 when user focuses TextEditor
                    .overlay {
                        withAnimation {
                            Text("Ask \(engine.name.capitalizeFirst())")
                                .opacity(isEditing || !viewModel.request.isEmpty ? 0 : 1)
                                .offset(y: -8)
                                .foregroundColor(engine.color)
                                .fontWeight(.semibold)
                        }
                    }
                    // When TextEditor is focused, isEditing is true
                    .focused($isEditing)
                    // TextEditor is disabled after request is submitted
                    .disabled(viewModel.inProgress || viewModel.complete)
                    // Text font color turns gray after request is submitted
                    .foregroundColor(viewModel.inProgress || viewModel.complete ? .gray : .primary)
                // Call to action
                Text(promptSuggestion)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .italic()
                    .multilineTextAlignment(.center)
            }
        } header: {
            Text(engine == .DALLE ? "Create with Artificial Intelligence" : "Chat with Artificial Intelligence")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
                .padding(2)
        }
    }
}

struct RequestView_Previews: PreviewProvider {
    static let viewModel = OpenAIViewModel.example
    static var previews: some View {
        VStack {
            RequestView(viewModel: viewModel, engine: .DALLE)
        }
    }
}
