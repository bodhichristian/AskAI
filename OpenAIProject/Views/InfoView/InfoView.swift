//
//  MenuView.swift
//  OpenAIProject
//
//  Created by christian on 1/30/23.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://wwww.coingecko.com")!
    let githubURL = URL(string: "https://www.github.com/bodhichristian")!
    let twitterURL = URL(string: "https://twitter.com/bodhichristian")!
    
    var body: some View {
        NavigationView {
            List {
                developerCredits
                appLinks
            }
            
            .tint(.blue)
            //.listStyle(GroupedListStyle())
            .navigationTitle("Info")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            })
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

extension InfoView {
    
    
    
    private var developerCredits: some View {
        Section {
            HStack {
                Image("christian")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Text("AskAI was developed by Christian Lavelle as an approachable way to experience interfacing with OpenAI's ChatGPT")
                    .font(.callout)
                    //.foregroundColor(.theme.accent)
            }
            .padding(.vertical, 4)
            
            HStack {
                Link(destination: githubURL, label: {
                    HStack{
                        Image("github-mark")
                            .resizable().scaledToFit()
                            .frame(width: 20)
                        Image("github")
                            .resizable().scaledToFit()
                            .frame(width: 80)
                        Text("/bodhichristian")
                    }
                })
            }
            HStack {
                Link(destination: githubURL, label: {
                    HStack{
                        Image("twitter")
                            .resizable().scaledToFit()
                            .frame(width: 20)
                        Text("Twitter")
                            .fontWeight(.bold)
                            .padding(.leading, 4)
                        Text("@bodhichristian")
                    }
                })
            }        } header: {
            Text("Developer")
        }
    }
    
    private var appLinks: some View {
        Section {
        Link("Terms of Service", destination: defaultURL)
        Link("Privacy Policy", destination: defaultURL)
        Link("AskAI Website", destination: defaultURL)
        Link("Learn More", destination: defaultURL)
            
        } header: {
            Text("More")
        }

    }
}
