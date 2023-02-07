//
//  ChatViewModel.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import SwiftUI
import Foundation
import OpenAISwift

@MainActor class ChatViewModel: ObservableObject {
    // "REPLACE THIS TEXT WITH YOUR OPENAI API KEY"
    let openAI = OpenAISwift(authToken: "REPLACE THIS TEXT WITH YOUR OPENAI API KEY")
    
    //let engines = ["davinci", "curie", "babbage", "ada"]
    
    // 1 token = approx 4 characters, or 0.75 English words.
    // Total length limit (request + response) is 2048 tokens - about 1500 words
    let maxTokens = 1000
    let davinciMaxTokens = 4000
    
    @Published var request: String
    @Published var response: String
    @Published var inProgress: Bool
    @Published var complete: Bool
    @Published var errorMessage: String? = nil
    
    init(request: String = "", response: String = "") {
        self.request = request
        self.response = response
        self.inProgress = false
        self.complete = false
    }
    
    static let example = ChatViewModel(request: "This is a test request", response: "This is a test response, no Articifical Intelligence here...")
    
    // Sends request to ChatGPT, using enging specified, and engine-appropriate max tokens
    func submitRequest(_ request: String, engine: ChatEngine) async -> () {
        do {
            let result = try await openAI.sendCompletion(
                with: request, model: .gpt3(engine.model),
                maxTokens: engine.model == .davinci ? davinciMaxTokens : maxTokens
            )
            response = result.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            complete = true
        } catch {
            response = error.localizedDescription
            complete = true
        }
    }
}

