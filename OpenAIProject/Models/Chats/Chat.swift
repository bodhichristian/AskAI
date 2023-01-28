//
//  Chat.swift
//  OpenAIProject
//
//  Created by christian on 1/26/23.
//

import SwiftUI

class Chat: Identifiable, Codable, ObservableObject {
    var id: UUID
    var request: String
    var response: String
    var date: Date
    var engine: String
    var notes = ""
    @Published var isFavorite: Bool
    
    enum CodingKeys: CodingKey {
        case id, request, response, date, engine, notes, isFavorite
    }
    
    init(id: UUID = UUID(), request: String, response: String, date: Date = Date(), engineUsed: String, notes: String = "", isFavorite: Bool = false) {
        self.id = id
        self.request = request
        self.response = response
        self.date = .now
        self.engine = engineUsed
        self.notes = ""
        self.isFavorite = false
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.request = try container.decode(String.self, forKey: .request)
        self.response = try container.decode(String.self, forKey: .response)
        self.date = try container.decode(Date.self, forKey: .date)
        self.engine = try container.decode(String.self, forKey: .engine)
        self.notes = try container.decode(String.self, forKey: .notes)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(request, forKey: .request)
        try container.encode(response, forKey: .response)
        try container.encode(date, forKey: .date)
        try container.encode(engine, forKey: .engine)
        try container.encode(notes, forKey: .notes)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
    
    static let example = Chat(request: "This is a really interesting chat request example", response: "This response example is, inconceivably so, even more interesting than the request.", engineUsed: "davinci")
}
