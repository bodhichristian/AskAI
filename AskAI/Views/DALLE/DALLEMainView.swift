//
//  DALLEMainView.swift
//  OpenAIProject
//
//  Created by christian on 2/8/23.
//

import SwiftUI

struct DALLEMainView: View {
    @StateObject var dallESavedChats = SavedChats()
    @StateObject var dallEVM = OpenAIViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    // When showingDeleteAlert is toggled, an alert is presented to confirm action
    @State private var showingDeleteAlert = false
    @State private var deleteAlertTitle = Text("Image deleted.")
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Create an Image with AI")) {
                    NavigationLink {
                        DALLEPromptView(viewModel: dallEVM, engine: .DALLE)
                    } label: {
                        EngineLabelView(engine: .DALLE)
                    }
                }
                
                Section(header: Text("Saved Images")) {
                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .leading) {
                            ForEach(dallESavedChats.chats.sorted(by: { $0.date < $1.date }).reversed()) { chat in
                                NavigationLink {
                                    Text("GeneratedImageView coming soon...")
                                } label: {
                                    VStack(alignment: .leading) {
                                        Image(uiImage: chat.generatedImage ?? UIImage(named: "chatGPT")!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 101, height: 140)
                                            .cornerRadius(10)
                                           //.padding(4)
                                            //.shadow(color: .secondary, radius: 2, x: 4, y: 6)
                                        
                                            .overlay {
                                                HStack {
                                                    VStack(alignment: .leading) {
                                                    Text(chat.request)
                                                        .font(.caption)
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.white)
                                                        .lineLimit(1)
                                                        //.padding(.horizontal, 4)

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
                    .navigationTitle("Ask DALL·E")
                }

            }
        }
        .environmentObject(dallESavedChats)

    }
}
    
    struct DALLEMainView_Previews: PreviewProvider {
        
        static var previews: some View {
            DALLEMainView()
                .environmentObject(SavedChats())
            
        }
    }
