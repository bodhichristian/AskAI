//
//  Created by Adam Rush - OpenAISwift
//

import Foundation

public struct OpenAIChat: Codable {
    public let object: String
    public let model: String?
    public let choices: [Choice]
}

public struct Choice: Codable {
    public let text: String
}
