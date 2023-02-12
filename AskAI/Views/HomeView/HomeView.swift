//
//  HomeView.swift
//  OpenAIProject
//
//  Created by christian on 2/9/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = OpenAIViewModel()

    @ObservedObject var totalRequests: TotalRequests
    @ObservedObject var savedChats: SavedChats
    @ObservedObject var profile: Profile

    // When showingInfoView is toggled, a modal sheet will present InfoView
    @State private var showingInfoView = false
    
    let redditChatGPT = URL(string: "https://www.reddit.com/r/ChatGPT/")!
    let redditDALLE = URL(string: "https://www.reddit.com/r/dalle2/")!
    let twitterChatGPT = URL(string: "https://twitter.com/search?q=%23ChatGPT")!
    let twitterDALLE = URL(string: "https://twitter.com/search?q=%23dalle2")!
    
    @State private var showingWelcomeMessage = false
    @State private var fallingOffset = -10.0
    @State private var risingOffset = 10.0
    @State private var expandingShadowRadius = 0.0
    @State private var diminishingShadowRadius = 40.0
    
    @State private var usernameTheme = UsernameTheme.mint
    
    var savedChatCount: Int {
        let chatGPTFilter = savedChats.chats.filter { chat in
            return chat.engine != .DALLE
        }
        return chatGPTFilter.count
    }
    
    var savedImageCount: Int {
        let dallEFilter = savedChats.chats.filter { chat in
            return chat.engine == .DALLE
        }
        return dallEFilter.count
    }

    
    var body: some View {
        NavigationView {
            VStack {
                CircleImage(imageName: "askAI-logo", width: 255, height: 255)
                    .shadow(color: .secondary, radius: diminishingShadowRadius)
                    .shadow(color: .purple, radius: expandingShadowRadius)
                    .padding(45)
                
                HStack(spacing: 0) {
                    Text("Hello, ")
                    Text("\(profile.username)")
                        .foregroundColor(usernameTheme.mainColor)
                    Text(".")
                }
                .bold()
                .font(.title)
                
                Text("What will we create today?")
                    .padding(.bottom, 10)
                    .opacity(showingWelcomeMessage ? 1 : 0)
                    .offset(y: fallingOffset)
                
                Spacer()
                
                HStack {
                    Text("Get inspired:")
                        .foregroundColor(.secondary)
                        .offset(y: fallingOffset)
 
                        .padding(.leading)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Link(destination: redditChatGPT) {
                        HStack {
                            Image("reddit")
                                .resizable().scaledToFit()
                                .frame(width: 20)
                                .offset(y: fallingOffset)
                            
                            Text("r/ChatGPT")
                                .offset(y: risingOffset)
                            
                        }
                    }
                    
                    Link(destination: redditChatGPT) {
                        Text("r/dalle2")
                            .offset(y: fallingOffset)
                        
                    }
                    Spacer()
                    Link(destination: twitterChatGPT) {
                        HStack {
                            Image("twitter")
                                .resizable().scaledToFit()
                                .frame(width: 20)
                                .offset(y: fallingOffset)
                            
                            Text("#ChatGPT")
                                .offset(y: risingOffset)
                            
                        }
                    }
                    
                    Link(destination: twitterDALLE) {
                        Text("#dalle2")
                            .offset(y: fallingOffset)
                        
                    }
                    Spacer()
                }
                Divider()
                    .padding(5)
                    .padding(.horizontal, 6)
                
                HStack {
                    Text("Achievements:")
                        .foregroundColor(.secondary)
                        .offset(y: fallingOffset)
                        .padding(.leading)
                        .padding(.bottom, -10)
                    Spacer()
                }
                
                
                HStack {
                    VStack {
                        HStack(alignment: .center) {
                            Text("\(savedChats.chats.count)")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .offset(y: risingOffset)
                            
                            
                            Image(systemName: "quote.bubble.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.purple)
                                .offset(y: fallingOffset)
                            
                        }
                        Text("Saved chats")
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack(alignment: .center) {
                            Text("\(totalRequests.count)")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .offset(y: risingOffset)
                            
                            Image(systemName: "questionmark.bubble.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.green)
                                .offset(y: fallingOffset)
                            
                        }
                        Text("AskAI Requests")
                            .font(.footnote)

                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack(alignment: .center) {
                            Text("\(savedImageCount)")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .offset(y: risingOffset)
                            
                            Image(systemName: "rectangle.3.group.bubble.left.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                                .offset(y: fallingOffset)
                            
                        }
                        Text("Saved images")
                            .font(.footnote)

                    }
                }
                .padding(.horizontal)
                .padding(.bottom)

            }
            
            .navigationTitle("AskAI")
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8)) {
                    showingWelcomeMessage = true
                    fallingOffset = 0
                    risingOffset = 0
                    expandingShadowRadius = 30
                    diminishingShadowRadius = 8
                }
            }
            .toolbar {
                Button {
                    showingInfoView.toggle()
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(isPresented: $showingInfoView) {
            SettingsView(usernameTheme: $usernameTheme)
                .environmentObject(profile)
        }
//        .environmentObject(savedChats)
//        .environmentObject(totalRequests)
//        .environmentObject(viewModel)
//        .environmentObject(profile)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(totalRequests: TotalRequests(), savedChats: SavedChats(), profile: Profile(username: "user"))
//            .environmentObject(Profile(username: "user"))
//            .environmentObject(SavedChats())
    }
}
