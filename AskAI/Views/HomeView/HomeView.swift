//
//  HomeView.swift
//  OpenAIProject
//
//  Created by christian on 2/9/23.
//

import SwiftUI

struct HomeView: View {
    var profile: Profile
    
    // When showingInfoView is toggled, a modal sheet will present InfoView
    @State private var showingInfoView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Hello, \(profile.username).")
                    .bold()
                    .font(.title)
            }
            .navigationTitle("AskAI")
            .toolbar {
                Button {
                    showingInfoView.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            .sheet(isPresented: $showingInfoView) {
                InfoView()
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(profile: Profile.default)
    }
}
