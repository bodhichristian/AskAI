//
//  ChatViewModel.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import Foundation
import OpenAISwift

@MainActor class ChatViewModel: ObservableObject {
    // "REPLACE THIS TEXT WITH YOUR OPENAI API KEY"
    let openAI = OpenAISwift(authToken: "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")
    
    // 1 token = approx 4 characters, or 0.75 English words.
    // total length limit (request + response) is 2048 tokens - about 1500 words
    let maxTokens = 1000
    
    @Published var request: String
    @Published var response: String
    @Published var isLoading: Bool
    @Published var firstRequest: Bool
    @Published var errorMessage: String? = nil
    
    init(request: String, response: String, isLoading: Bool, firstRequest: Bool) {
        self.request = ""
        self.response = ""
        self.isLoading = false
        self.firstRequest = true
    }
    
    static let example = ChatViewModel(request: "This is a test request", response: "This is a test response, no Articifical Intelligence here...", isLoading: false, firstRequest: false)
    
    // takes a request string, and sets response equal to the return value from sendCompletion()
    // takes optional parameter model to select level of fine tuning
    // model: .gpt(.davinci) up to 4000 tokens*, most capable model
    // model: .gpt(.curie) extremely powerful, yet very fast
    // model: .gpt(.babbage) straightforward tasks like simple classification
    // model: .gpt(.ada) usually the fastest model. performance can be improved with more context
    func submitRequest(_ request: String) async -> () {
        do {
            let result = try await openAI.sendCompletion(with: request, model: .gpt3(.davinci),  maxTokens: maxTokens)
            response = result.choices.first?.text ?? ""
        } catch {
            response = error.localizedDescription
        }
    }
}

