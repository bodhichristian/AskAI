//
//  ChatEngine.swift
//  OpenAIProject
//
//  Created by christian on 2/6/23.
//

import SwiftUI
import Foundation

enum Engine: Codable {
    // Most capable GPT-3 model. can do any task the other models can do, often with higher quality, longer output and better instruction-following.
    case davinci
    // Very capable, but faster and lower cost than Davinci.
    case curie
    // Capable of straightforward tasks, very fast, and lower cost.
    case babbage
    // Capable of very simple tasks, usually the fastest model and lowest cost.
    case ada
    // Image generation
    case DALLE
    
    
    var model: OpenAIModelType.GPT3 {
        switch self {
        case .davinci: return .davinci
        case .curie: return .curie
        case .babbage: return .babbage
        case .ada: return .ada
        default: return .davinci
        }
    }
    
    var name: String {
        switch self {
        case .davinci: return "davinci"
        case .curie: return "curie"
        case .babbage: return "babbage"
        case .ada: return "ada"
        case .DALLE: return "Dall-E"
        }
    }
    
    var description: String {
        switch self {
        case .davinci: return "Most capable"
        case .curie: return "Powerful, yet fast"
        case .babbage: return "Straightforward tasks"
        default: return "Fast and simple"
        }
    }
    
    var color: Color {
        switch self {
        case .davinci: return .mint
        case .curie: return .purple
        case .babbage: return .green
        case .ada: return Color(red: 1, green: 0.2, blue: 0.6)
        case .DALLE: return .blue
        }
    }
}
