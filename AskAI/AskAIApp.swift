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
    @StateObject var profile = Profile()
    @StateObject var totalRequests = TotalRequests()

    var body: some Scene {
        WindowGroup {
            MainView(profile: profile, totalRequests: totalRequests)
                .environmentObject(savedChats)
        }
    }
}
