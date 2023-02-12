//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 2/9/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var savedChats: SavedChats
    @ObservedObject var profile: Profile
    @ObservedObject var totalRequests: TotalRequests
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            ChatGPTMainView(totalRequests: totalRequests, savedChats: savedChats)
                .tabItem {
                    Label("ChatGPT", systemImage: "character.cursor.ibeam")
                }
                .tag(0)
            
            HomeView(totalRequests: totalRequests, savedChats: savedChats, profile: profile)
                .tabItem {
                    Label("Home", systemImage: "rotate.3d")
                }
                .tag(1)
            
            DALLEMainView(savedChats: savedChats, totalRequests: totalRequests)
                .tabItem {
                    Label("DALL-E", systemImage: "bubbles.and.sparkles.fill")
                }
                .tag(2)
        }
        .environmentObject(savedChats)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(profile: Profile(username: "user"), totalRequests: TotalRequests())
                .environmentObject(SavedChats())
    }
}
