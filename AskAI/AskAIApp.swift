//
//  OpenAIProjectApp.swift
//  OpenAIProject
//
//  Created by christian on 1/12/23.
//

import SwiftUI

@main
struct AskAIApp: App {
    @StateObject var savedChats = SavedChats()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(savedChats)
        }
    }
}
