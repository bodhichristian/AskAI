//
//  ChatViewModel.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import Foundation
import OpenAISwift

class ChatViewModel: ObservableObject {
    // "REPLACE THIS TEXT WITH YOUR OPENAI API KEY"
    let openAI = OpenAISwift(authToken: "PLACEHOLDER STRING")
    
    @Published var request: String
    @Published var response: String
    @Published var isLoading: Bool
    @Published var firstRequest: Bool
    
    init(request: String, response: String, isLoading: Bool, firstRequest: Bool) {
        self.request = ""
        self.response = ""
        self.isLoading = false
        self.firstRequest = true
    }
    
    static let example = ChatViewModel(request: "This is a test request", response: "This is a test response, no Articifical Intelligence here...", isLoading: false, firstRequest: false)
    
    // takes a request string, and sets response equal to the return value from sendCompletion()
    func submitRequest(_ request: String) async -> () {
        do {
            let result = try await openAI.sendCompletion(with: request, maxTokens: 500)
            response = result.choices.first?.text ?? ""
        } catch {
            print(error.localizedDescription)
        }
    }
}

