//
//  Profile.swift
//  OpenAIProject
//
//  Created by christian on 2/9/23.
//

import Foundation

class Profile: ObservableObject {
    @Published var username: String
    
    init(username: String) {
        self.username = username
    }
}
