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
    
    // Animation state values
    @State private var showingWelcomeMessage = false
    @State private var fallingOffset = -10.0
    @State private var risingOffset = 10.0
    @State private var expandingShadowRadius = 0.0
    @State private var diminishingShadowRadius = 40.0

    // When showingInfoView is toggled, a modal sheet will present InfoView
    @State private var showingSettingsView = false
    
    // Returns number of saved text chats
    var savedChatCount: Int {
        let chatGPTFilter = savedChats.chats.filter { chat in
            return chat.engine != .DALLE
        }
        return chatGPTFilter.count
    }
    
    // Returns number of saved images
    var savedImageCount: Int {
        let dallEFilter = savedChats.chats.filter { chat in
            return chat.engine == .DALLE
        }
        return dallEFilter.count
    }
    
    // Social Links
    let redditChatGPT = URL(string: "https://www.reddit.com/r/ChatGPT/")!
    let redditDALLE = URL(string: "https://www.reddit.com/r/dalle2/")!
    let twitterChatGPT = URL(string: "https://twitter.com/search?q=%23ChatGPT")!
    let twitterDALLE = URL(string: "https://twitter.com/search?q=%23dalle2")!
    
    var body: some View {
        NavigationView {
            VStack {
                // Welcome View: Circle Image and Greeting
                welcomeView
                
                // Dashboard View: User stat block
                dashboardView
                
                // Conversation View: Reddit & Twitter links
                conversationView
            }
            .navigationTitle(Text("AskAI"))
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8)) {
                    animate()
                }
            }
            // Settings Gear reveals SettingsView on tap
            .toolbar {
                Button {
                    showingSettingsView.toggle()
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        // Modal sheet presents SettingsView
        .sheet(isPresented: $showingSettingsView) {
            SettingsView(userTheme: $profile.theme)
                .environmentObject(profile)
        }
    }
}

extension HomeView {
    // Welcome View
    // Circle Image and greeting
    private var welcomeView: some View {
        VStack {
            CircleImage(imageName: "askAI-logo", width: 200, height: 200)
                .shadow(color: .secondary, radius: diminishingShadowRadius)
                .shadow(color: profile.theme.mainColor, radius: expandingShadowRadius)
                .padding(15)
            
            // Greeting:
            // Hello, <user>.
            // What will we create today?
            HStack(spacing: 0) {
                Text("Hello, ")
                Text("\(profile.username)")
                    .foregroundColor(profile.theme.mainColor)
                Text(".")
            }
            .bold()
            .font(.title)
            
            Text("What will we create today?")
                .opacity(showingWelcomeMessage ? 1 : 0)
                .offset(y: fallingOffset)
                .padding(.bottom)
        }
    }
    
    // Dashboard View
    // AskAI requests, saved chats, and saved images
    private var dashboardView: some View {
        VStack {
            HStack {
                Text("Dashboard")
                    .font(.headline)
                    .offset(y: fallingOffset)
                    .padding([.leading, .top])
                
                Spacer()
            }
            
            HStack {
                // Saved Chats
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
                
                // AskAI Requests
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
                
                // Saved Images
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
                    .foregroundColor(profile.theme.mainColor.opacity(0.2))
            }
        )
        .padding(.horizontal)
    }
    
    // Join the Conversation
    // Reddit and Twitter links
    private var conversationView: some View {
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
                    .foregroundColor(profile.theme.mainColor.opacity(0.2))

            }

        )
        .padding()
    }
    
    // Animate Function
    // Sets animation state values to defaults
    private func animate() {
        showingWelcomeMessage = true
        fallingOffset = 0
        risingOffset = 0
        expandingShadowRadius = 15
        diminishingShadowRadius = 8
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(totalRequests: TotalRequests(), savedChats: SavedChats(), profile: Profile())
    }
}
