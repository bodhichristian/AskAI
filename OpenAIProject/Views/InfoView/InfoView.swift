//
//  MenuView.swift
//  OpenAIProject
//
//  Created by christian on 1/30/23.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    let defaultURL = URL(string: "https://www.google.com")!
    let openAIURL = URL(string: "https://openai.com/")!
    let chatGPTURL = URL(string: "https://chat.openai.com/")!
    let openAIAPIURL = URL(string: "https://openai.com/api/")!
    let githubURL = URL(string: "https://www.github.com/bodhichristian")!
    let twitterURL = URL(string: "https://twitter.com/bodhichristian")!
    
    var body: some View {
        NavigationView {
            List {
                openAICredits
                developerCredits
                appLinks
            }
            //.tint(.blue)
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
                        Image(colorScheme == .light ? "github-mark" : "github-mark-white")
                            .resizable().scaledToFit()
                            .frame(width: 20)
                        Image(colorScheme == .light ? "github" : "github-white")
                            .resizable().scaledToFit()
                            .frame(width: 65)
                        Text("/bodhichristian")
                    }
                })
            }
            HStack {
                Link(destination: twitterURL, label: {
                    HStack{
                        Image("twitter")
                            .resizable().scaledToFit()
                            .frame(width: 20)
                        Text("Twitter")
                            .fontWeight(.black)
                            .padding(.leading, 4)
                            .foregroundColor(Color("TwitterBlue"))
                        Text("@bodhichristian")
                    }
                })
            }        } header: {
            Text("Developer")
        }
    }
    
    private var openAICredits: some View {
        Section {
            HStack {
                Text("OpenAI has created a model called ChatGPT which is trained to interact in a conversational way.")
                CircleImage(engine: "ChatGPT", width: 80, height: 80)
            }
            Link("OpenAI", destination: openAIURL)
            Link("ChatGPT", destination: chatGPTURL)
            Link("OpenAI API", destination: openAIAPIURL)


        } header: {
            Text("OpenAI")
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
