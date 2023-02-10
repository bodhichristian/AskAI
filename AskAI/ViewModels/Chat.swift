//
//  Chat.swift
//  OpenAIProject
//
//  Created by christian on 1/26/23.
//

import UIKit
import SwiftUI

class Chat: Identifiable, Codable, ObservableObject {
    var id: UUID
    var request: String
    var response: String
    var date: Date
    var engine: Engine
    var generatedImage: UIImage?
    @Published var isFavorite: Bool
    
    enum CodingKeys: CodingKey {
        case id, request, response, date, engine, generatedImage, isFavorite
    }
    
    init(id: UUID = UUID(), request: String, response: String, date: Date = Date(), engine: Engine, isFavorite: Bool = false, generatedImage: UIImage? = nil) {
        self.id = id
        self.request = request
        self.response = response
        self.date = .now
        self.engine = engine
        self.generatedImage = generatedImage
        self.isFavorite = isFavorite
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.request = try container.decode(String.self, forKey: .request)
        self.response = try container.decode(String.self, forKey: .response)
        self.date = try container.decode(Date.self, forKey: .date)
        self.engine = try container.decode(Engine.self, forKey: .engine)
        
        
        
        self.generatedImage = UIImage(data: try container.decode(Data.self, forKey: .generatedImage))
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(request, forKey: .request)
        try container.encode(response, forKey: .response)
        try container.encode(date, forKey: .date)
        try container.encode(engine, forKey: .engine)
        try container.encode(generatedImage?.pngData(), forKey: .generatedImage)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
    
    static let example = Chat(request: "This is a really interesting chat request example", response: "This response example is, inconceivably so, even more interesting than the request.", engine: .davinci, isFavorite: true)
}
