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
    
    // App will launch to selectedTab
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            
            // ChatGPT Tab
            ChatGPTMainView(totalRequests: totalRequests, savedChats: savedChats)
                .tabItem {
                    Label("ChatGPT", systemImage: "character.cursor.ibeam")
                }
                .tag(0)
            
            // Home Tab
            HomeView(totalRequests: totalRequests, savedChats: savedChats, profile: profile)
                .tabItem {
                    Label("Home", systemImage: "rotate.3d")
                }
                .tag(1)
            
            
            // DALL·E Tab
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
        MainView(profile: Profile(), totalRequests: TotalRequests())
                .environmentObject(SavedChats())
    }
}
