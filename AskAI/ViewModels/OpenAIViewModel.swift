//
//  ChatViewModel.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import UIKit
import SwiftUI
import Foundation
import OpenAIKit
import OpenAISwift

// Replace empty string with your OpenAI API key
let apiKey = ""
let config = Configuration(organization: "Personal", apiKey: apiKey)

@MainActor class OpenAIViewModel: ObservableObject {
    
    let chatGPT = OpenAISwift(authToken: apiKey)
    let dallE = OpenAI(config)
    
    // For ChatGPT
    // 1 token = approx 4 characters, or 0.75 English words.
    // Total length limit (request + response) is 2048 tokens - about 1500 words
    let maxTokens = 1000
    let davinciMaxTokens = 4000
    
    @Published var request: String
    @Published var response: String
    @Published var inProgress: Bool
    @Published var complete: Bool
    @Published var errorMessage: String? = nil
    @Published var generatedImage: UIImage? = nil
    
    init(request: String = "", response: String = "", generatedImage: UIImage? = nil) {
        self.request = request
        self.response = response
        self.inProgress = false
        self.complete = false
        self.generatedImage = nil
    }
    
    static let example = OpenAIViewModel(request: "This is a test request", response: "This is a test response, no Articifical Intelligence here...", generatedImage: UIImage(named: "chatGPT"))
    
    // Sends request to ChatGPT, using enging specified, and engine-appropriate max tokens
    func submitRequest(_ request: String, engine: Engine) async -> () {
        inProgress = true
        do {
            let result = try await chatGPT.sendCompletion(
                with: request, model: .gpt3(engine.model),
                maxTokens: engine.model == .davinci ? davinciMaxTokens : maxTokens
            )
            response = result.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            inProgress = false
            complete = true
        } catch {
            response = error.localizedDescription
            inProgress = false
            complete = true
        }
    }
    
    
    // For DALLE
    @Published var imagePrompt: String = ""
    
    func generateImage(prompt: String) async -> () {

        do {
            let imageParam = ImageParameters(
                prompt: prompt,
                resolution: .small,
                responseFormat: .base64Json
            )
            let result = try await dallE.createImage(
                parameters: imageParam
            )
            let b64Image = result.data[0].image
            let image = try dallE.decodeBase64Image(b64Image)
            print("Image decoded successfully")
            generatedImage = image
            complete = true
        } catch {
            print("Error: \(error.localizedDescription)")
            complete = true
            generatedImage = UIImage(named: "twitter")
        }
    }
}

