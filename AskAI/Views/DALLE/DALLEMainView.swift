//
//  DALLEMainView.swift
//  OpenAIProject
//
//  Created by christian on 2/8/23.
//

import SwiftUI

struct DALLEMainView: View {
    @ObservedObject var savedChats: SavedChats
    @ObservedObject var totalRequests: TotalRequests
    @StateObject var dallEVM = OpenAIViewModel()
    
    // Computes an array of Chats, filtering out ChatGPT-baseed saved chats
    var filteredChats: [Chat] {
        savedChats.chats.filter { chat in
            return chat.engine == .DALLE
        }
    }
    
    // Columns for LazyVGrid in savedImagesSection
    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    // When showingDeleteAlert is toggled, an alert is presented to confirm action
    @State private var showingDeleteAlert = false
    @State private var deleteAlertTitle = Text("Image deleted.")
    
    // When showingInfoView is toggled, a modal sheet will present
    @State private var showingInfoView = false
    
    var body: some View {
        NavigationView {
            List {
                createAnImageSection
                savedImagesSection
            }
            .toolbar {
                Button {
                    showingInfoView.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
            .navigationTitle("Ask DALL·E")
            .sheet(isPresented: $showingInfoView) {
                DALLEInfoView()
            }
        }
        .environmentObject(savedChats)
    }
}

extension DALLEMainView {
    
    private var createAnImageSection: some View {
        Section(header: Text("Create an Image with AI")) {
            NavigationLink {
                DALLEPromptView(viewModel: dallEVM, totalRequests: totalRequests,  engine: .DALLE)
            } label: {
                EngineLabelView(engine: .DALLE)
            }
        }
    }
    
    private var savedImagesSection: some View {
        Section(header: Text("Saved Images")) {
            if filteredChats.isEmpty {
                Text("Create a new image above. Saved images will appear here.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding()
                    .offset(x: 7)
            }
            else {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading) {
                        ForEach(filteredChats.sorted(by: { $0.date < $1.date }).reversed()) { chat in
                            NavigationLink {
                                SavedChatView(chat: chat, engine: chat.engine)
                            } label: {
                                VStack(alignment: .leading) {
                                    Image(uiImage: chat.generatedImage ?? UIImage(named: "chatGPT")!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 101, height: 140)
                                        .cornerRadius(10)
                                        .overlay {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(chat.request)
                                                        .font(.caption)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.white)
                                                        .lineLimit(1)
                                                    
                                                    Text(chat.date, format: .dateTime.month().day().year())
                                                        .font(.caption2)
                                                        .foregroundColor(.white.opacity(0.7))
                                                }
                                                .padding(4)
                                                
                                                Spacer()
                                            }
                                            .frame(maxWidth: .infinity)
                                            .background(LinearGradient(colors: [.black.opacity(0.6), .black.opacity(0.2)], startPoint: .top, endPoint: .bottom))
                                            .offset(y: 52)
                                            
                                        }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 7)
                            }
                        }
                    }
                    // Padding between the grid and the Section container
                    .padding([.horizontal, .bottom, .top])
                }
                .padding(.horizontal, -16)
            }
        }
    }

}

extension DALLEMainView {
}

struct DALLEMainView_Previews: PreviewProvider {
    static var previews: some View {
        DALLEMainView( savedChats: SavedChats(), totalRequests: TotalRequests())        
    }
}
