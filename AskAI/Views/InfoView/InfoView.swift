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
                davinciInfo
                curieInfo
                babbageInfo
                adaInfo
                    
                openAICredits
                developerCredits
                appLinks
            }
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
                    .shadow(radius: 4)
                Text("AskAI was developed by Christian Lavelle as an approachable, native to iOS way to experience interfacing with OpenAI's ChatGPT.")
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
                            .foregroundColor(Color("twitterBlue"))
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
                Text("ChatGPT is a model trained by OpenAI to respond to text prompts in a conversational way. OpenAI seeks to make AI systems more natural and safe to interact with. ChatGPT is in a research preview, and you may not get desired results.")
                    .font(.callout)
                CircleImage(engine: "chatGPT", width: 80, height: 80)
            }
            Link("OpenAI", destination: openAIURL)
            Link("ChatGPT", destination: chatGPTURL)
            Link("OpenAI API", destination: openAIAPIURL)


        } header: {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.vertical)
                Text("OpenAI")
            }
        }
    }
    
    private var davinciInfo: some View {
        Section {
            VStack {
                CircleImage(engine: "davinci", width: 100, height: 100)
                    .padding(5)

                Text("Davinci is the most capable chat engine. For uses requiring a lot of understanding of the content, like summarization for a specific audience and creative content generation, Davinci is going to produce the best results.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
            }
        } header: {
            Text("Davinci")
                .bold()
                .foregroundColor(.mint)
        }
    }
    
    private var curieInfo: some View {
        Section {
            VStack {
                CircleImage(engine: "curie", width: 100, height: 100)
                    .padding(5)

                Text("Curie is extremely powerful, yet very fast. While Davinci is stronger when it comes to analyzing complicated text, Curie is quite good at answering questions and performing Q&A and as a general service chatbot.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
            }
        } header: {
            Text("Curie")
                .bold()
                .foregroundColor(.purple)
        }
    }
    
    private var babbageInfo: some View {
        Section {
            VStack {
                CircleImage(engine: "babbage", width: 100, height: 100)
                    .padding(5)

                Text("Babbage can perform straightforward tasks like simple classification. It’s also quite capable when it comes to Semantic Search ranking how well documents match up with search queries.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
            }
        } header: {
            Text("Babbage")
                .bold()
                .foregroundColor(.green)
        }
    }
    
    private var adaInfo: some View {
        Section {
            VStack {
                CircleImage(engine: "ada", width: 100, height: 100)
                    .padding(5)

                Text("Ada is usually the fastest model and can perform tasks like parsing text, address correction and certain kinds of classification tasks that don’t require too much nuance.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
            }
        } header: {
            Text("Ada")
                .bold()
                .foregroundColor(Color(red: 3, green: 0.2, blue: 0.6))
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
