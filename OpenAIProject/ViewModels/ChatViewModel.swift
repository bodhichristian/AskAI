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
    
    let engines = ["davinci", "curie", "babbage", "ada"]
    
    // 1 token = approx 4 characters, or 0.75 English words.
    // total length limit (request + response) is 2048 tokens - about 1500 words
    let maxTokens = 1000
    let davinciMaxTokens = 4000
    
    @Published var request: String
    @Published var response: String
    @Published var inProgress: Bool
    @Published var complete: Bool
    @Published var firstRequest: Bool
    @Published var errorMessage: String? = nil
    
    init(request: String, response: String, isLoading: Bool, firstRequest: Bool) {
        self.request = ""
        self.response = ""
        self.inProgress = false
        self.complete = false
        self.firstRequest = true
        
    }
    
    static let example = ChatViewModel(request: "This is a test request", response: "This is a test response, no Articifical Intelligence here...", isLoading: false, firstRequest: false)
    
    enum Engine: String {
        // most capable GPT-3 model. can do any task the other models can do, often with higher quality, longer output and better instruction-following.
        case davinci = "davinci"
        // very capable, but faster and lower cost than Davinci.
        case curie = "curie"
        // capable of straightforward tasks, very fast, and lower cost.
        case babbage = "babbage"
        // capable of very simple tasks, usually the fastest model and lowest cost.
        case ada = "ada"
        
        var model: OpenAIModelType.GPT3 {
            switch self {
                case .davinci: return .davinci
                case .curie: return .curie
                case .babbage: return .babbage
                case .ada: return .ada
            }
        }
        
        var color: Color {
            switch self {
            case .davinci: return .mint
            case .curie: return .purple
            case .babbage: return .green
            case .ada: return Color(red: 3, green: 0.2, blue: 0.6)
            }
        }
    }
    
    
    // sends request to ChatGPT, using enging specified, and engine-appropriate max tokens
    func submitRequest(_ request: String, engine: String) async -> () {
        do {
            guard let engine = Engine(rawValue: engine) else {
                response = "Invalid engine specified"
                return
            }
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

