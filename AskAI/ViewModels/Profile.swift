//
//  Profile.swift
//  OpenAIProject
//
//  Created by christian on 2/9/23.
//

import Foundation

class Profile: ObservableObject {
    @Published var username: String
    @Published var theme: UserTheme
    
    let usernamePath = FileManager.documentsDirectory.appendingPathComponent("Profile")
    let themePath = FileManager.documentsDirectory.appendingPathComponent("UserTheme")
    
    init() {
        if let usernameData = try? Data(contentsOf: usernamePath),
           let decodedUsername = try? JSONDecoder().decode(String.self, from: usernameData) {
            username = decodedUsername
            print("Username decoded.")
        } else {
            username = "user"
            print("No username data found in Documents Directory")
        }
        
        if let themeData = try? Data(contentsOf: themePath),
           let decodedTheme = try? JSONDecoder().decode(UserTheme.self, from: themeData) {
            theme = decodedTheme
            print("User theme decoded.")
        } else {
            theme = .mint
            print("No user theme data found in Documents Directory")
        }
    }
    
    func save() {
        if let encodedUsername = try? JSONEncoder().encode(username) {
            try? encodedUsername.write(to: usernamePath, options: [.atomic, .completeFileProtection])
            print("Username updated.")
        }
        
        if let encodedTheme = try? JSONEncoder().encode(theme) {
            try? encodedTheme.write(to: themePath, options: [.atomic, .completeFileProtection])
            print("Theme updated.")
        }
    }
}
