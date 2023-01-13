//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 1/12/23.
//

import SwiftUI
import OpenAISwift

// "REPLACE THIS TEXT WITH YOUR OPENAI API KEY"
let openAI = OpenAISwift(authToken: "REPLACE THIS TEXT WITH YOUR OPENAI API KEY")

struct ContentView: View {
    @State private var request = ""
    @State private var response = ""
    @State private var isLoading = false
    @State private var firstRequest = true
    @FocusState private var editing: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.ultraThinMaterial)
                        .overlay {
                            if response == "" {
                                Text("Response will appear here.")
                            }
                        }
                    ScrollView {
                        Text(response)
                            .padding()
                    }
                }
                .overlay {
                    ZStack(alignment: .bottomTrailing) {
                        Rectangle()
                            .foregroundColor(.clear)
                        VStack(spacing: 8) {
                            Button {
                                withAnimation {
                                response = ""
                                isLoading = false
                                editing = false
                                }
                            } label : {
                                ZStack {
                                    Circle()
                                        .frame(width: 40)
                                        .foregroundColor(response.isEmpty ? .secondary.opacity(0.3) : .red.opacity(0.7))
                                        
                                        .offset(y: 5)
                                    Image(systemName: "trash")
                                        .offset(y: 5)
                                        .foregroundColor(.white)
                                }
                            }
                            .disabled(request.isEmpty)
                            ZStack{
                                Circle()
                                    .frame(width: 40)
                                    .foregroundColor(response.isEmpty ? .secondary.opacity(0.3) : .green.opacity(0.7))
                                    .padding(4)
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(4)
                    }
                }
                
                Section {
                    TextEditor(text: $request)
                        .frame(height: 100)
                        .cornerRadius(10)
                        .shadow(color: .secondary.opacity(0.5), radius: 8, y: 0)
                        .padding(.bottom, 8)
                        .overlay {
                            withAnimation {
                                Text("Ask ChatGPT")
                                    .opacity(editing || !request.isEmpty ? 0 : 1)
                                    .offset(y: -8)
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                            }
                        }.focused($editing)
                    
                    Text("Not sure what to prompt? Try \"Write me a song\" or \"Explain Quantum Mechanics like I'm five years old.\"")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .italic()
                } header: {
                    Text("Chat with Artificial Intelligence.")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                HStack {
                    Button {
                        isLoading = true
                        firstRequest = false
                        withAnimation {
                            openAI.sendCompletion(with: request, maxTokens: 1000) { result in //Result<OpenAI, OpenAIError
                                switch result {
                                case .success(let success):
                                    response = ""
                                    response = success.choices.first?.text ?? ""
                                case .failure(let failure):
                                    response = ""
                                    response = failure.localizedDescription
                                }
                            }
                        }
                    } label: {
                        Label("Submit", systemImage: "terminal")
                            .fontWeight(.semibold)
                            .padding(4)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(request.isEmpty || !response.isEmpty || isLoading)
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis.bubble.fill")
                        .resizable()
                        .frame(width: 34, height: 30)
                        .foregroundColor(request.isEmpty ? .secondary : .blue)
                        .opacity(!request.isEmpty || isLoading ? 1 : 0)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.arrow.down")
                        .resizable()
                        .frame(width: 40, height: 30)
                        .foregroundColor(.yellow)
                        .opacity(isLoading ? 1 : 0)
                    
                    Spacer()
                    
                    Image(systemName: "checkmark.seal")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor( .green)
                        .opacity(request.isEmpty || response.isEmpty ? 0 : 1)
                    
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Ask ChatGPT")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
