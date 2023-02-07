//
//  Created by Adam Rush - OpenAISwift
//

import Foundation

class Command: Encodable {
    let prompt: String
    let model: String
    let maxTokens: Int
    
    init(prompt: String, model: String, maxTokens: Int) {
        self.prompt = prompt
        self.model = model
        self.maxTokens = maxTokens
    }
    
    enum CodingKeys: String, CodingKey {
        case prompt
        case model
        case maxTokens = "max_tokens"
    }
}
