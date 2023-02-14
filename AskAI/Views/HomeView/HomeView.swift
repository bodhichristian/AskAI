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
    
    @State private var userTheme = UserTheme.mint
    
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
                CircleImage(imageName: "askAI-logo", width: 200, height: 200)
                    .shadow(color: .secondary, radius: diminishingShadowRadius)
                    .shadow(color: userTheme.mainColor, radius: expandingShadowRadius)
                    .padding(15)
                
                HStack(spacing: 0) {
                    Text("Hello, ")
                    Text("\(profile.username)")
                        .foregroundColor(userTheme.mainColor)
                    Text(".")
                }
                .bold()
                .font(.title)
                
                Text("What will we create today?")
                    .opacity(showingWelcomeMessage ? 1 : 0)
                    .offset(y: fallingOffset)
                    .padding(.bottom)
                
                
                // Dashboard section
                VStack {
                    HStack {
                        Text("Dashboard")
                            .font(.headline)
                            .offset(y: fallingOffset)
                            .padding([.leading, .top])
                        Spacer()
                    }
                    
                    
                    HStack {
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
                                Text("\(savedChatCount)")
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
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(userTheme.mainColor.opacity(0.2))
//                        RoundedRectangle(cornerRadius: 10)
//                            .foregroundStyle(.ultraThinMaterial)
                    }

                )
                .padding(.horizontal)
                
                // Join the conversation section
                VStack {
                    HStack {
                        Text("Join the Conversation")
                            .font(.headline)
                            .offset(y: fallingOffset)
     
                            .padding([.leading, .top])
                        Spacer()
                    }
                    
                    HStack {
                        // Reddit Link Stack
                        HStack {
                            Image("reddit")
                                .resizable().scaledToFit()
                                .frame(width: 40)
                                .offset(y: fallingOffset)
                            VStack(alignment: .leading, spacing: 6) {
                                Link(destination: redditChatGPT) {
                                    Text("r/ChatGPT")
                                        .offset(y: fallingOffset)
                                }
                                
                                    Link(destination: redditChatGPT) {
                                        Text("r/dalle2")
                                            .offset(y: risingOffset)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        // Twitter Link Stack
                        HStack {
                            Image("twitter")
                                .resizable().scaledToFit()
                                .frame(width: 40)
                                .offset(y: fallingOffset)
                            VStack(alignment: .leading, spacing: 6) {
                                Link(destination: twitterChatGPT) {
                                    Text("#chatGPT")
                                        .offset(y: fallingOffset)
                                }
                                    Link(destination: twitterDALLE) {
                                        Text("#dalle2")
                                            .offset(y: risingOffset)
                                }
                            }
                        }

                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(userTheme.mainColor.opacity(0.2))
//                        RoundedRectangle(cornerRadius: 10)
//                            .foregroundStyle(.ultraThinMaterial)
                    }

                )
                .padding()
            }
            
            .navigationTitle(Text("AskAI"))
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8)) {
                    showingWelcomeMessage = true
                    fallingOffset = 0
                    risingOffset = 0
                    expandingShadowRadius = 15
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
            SettingsView(userTheme: $userTheme)
                .environmentObject(profile)
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(totalRequests: TotalRequests(), savedChats: SavedChats(), profile: Profile(username: "user"))
//            .environmentObject(Profile(username: "user"))
//            .environmentObject(SavedChats())
    }
}
