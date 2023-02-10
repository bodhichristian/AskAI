//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 2/9/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var savedChats: SavedChats
    @State private var tabSelection = 1
    
    var profile = Profile.default
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ChatGPTMainView()
                .tabItem {
                    Label("ChatGPT", systemImage: "character.cursor.ibeam")
                }
            
            HomeView(profile: profile)
                .tabItem {
                    Label("Home", systemImage: "rotate.3d")
                }
                .tag(1)
            
            DALLEMainView()
                .tabItem {
                    Label("DALL-E", systemImage: "bubbles.and.sparkles.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SavedChats())
    }
}
