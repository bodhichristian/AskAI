//
//  MenuView.swift
//  OpenAIProject
//
//  Created by christian on 1/30/23.
//

import SwiftUI

struct SettingsView: View {
    @State var username = ""
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Username", text: $username)
                    
                }
            }
            .navigationTitle("Settings")
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
