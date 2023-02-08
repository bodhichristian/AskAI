//
//  ChatViewModel.swift
//  OpenAIProject
//
//  Created by christian on 1/19/23.
//

import SwiftUI
import Foundation
import OpenAIKit
import OpenAISwift

// "REPLACE THIS TEXT WITH YOUR OPENAI API KEY"
let apiKey = "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"

@MainActor class OpenAIViewModel: ObservableObject {
    
    let chatGPT = OpenAISwift(authToken: apiKey)
    let dallE = OpenAI(Configuration(organization: "Bodhicitta", apiKey: apiKey))
    
    /*
     For ChatGPT
     */
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
    
    static let example = OpenAIViewModel(request: "This is a test request", response: "This is a test response, no Articifical Intelligence here...")
    
    // Sends request to ChatGPT, using enging specified, and engine-appropriate max tokens
    func submitRequest(_ request: String, engine: Engine) async -> () {
        do {
            let result = try await chatGPT.sendCompletion(
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
    
    
    /*
     For DallE
     */
    @Published var imagePrompt: String = ""
    
    func generateImage(prompt: String) async -> UIImage? {
        do {
            // create generated image configuration
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            //
            let result =  try await dallE.createImage(parameters: params)
            
            // grab the first image data
            let data = result.data[0].image
            // decode image from base64
            let image = try dallE.decodeBase64Image(data)
            
            return image
        }
        catch{
            print(String(describing: error))
            return nil
        }
    }
}

