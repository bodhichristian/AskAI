//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 2/9/23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 1
    
    var profile = Profile.default
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ChatGPTMainView()
                .tabItem {
                    Label("ChatGPT", systemImage: "character.cursor.ibeam")
                }
                .tag(0)
            
            HomeView(profile: profile)
                .tabItem {
                    Label("Home", systemImage: "rotate.3d")
                }
                .tag(1)
            
            DALLEMainView()
                .tabItem {
                    Label("DALL-E", systemImage: "bubbles.and.sparkles.fill")
                }
                .tag(2)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
