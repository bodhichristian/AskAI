//
//  ContentView.swift
//  OpenAIProject
//
//  Created by christian on 2/9/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var savedChats: SavedChats
    var body: some View {
        TabView {
            ChatGPTMainView()
                .tabItem {
                    Label("ChatGPT", systemImage: "character.cursor.ibeam")
                }
            
            Text("MeView Coming soon.")
                .tabItem {
                    Label("Me", systemImage: "person.fill.viewfinder")
                }
            
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
