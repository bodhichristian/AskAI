//
//  DALLEMainView.swift
//  OpenAIProject
//
//  Created by christian on 2/8/23.
//

import SwiftUI

struct DALLEMainView: View {
    @EnvironmentObject var savedChats: SavedChats
    @StateObject var dallEVM = OpenAIViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
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
                        LazyVGrid(columns: columns) {
                            ForEach(savedChats.chats.sorted(by: { $0.date < $1.date }).reversed()) { chat in
                                NavigationLink {
                                    Text("GeneratedImageView coming soon...")
                                } label: {
                                    VStack {
                                        Image(uiImage: chat.generatedImage ?? UIImage(named: "chatGPT")!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 140, height: 180)
                                            .cornerRadius(10)
                                           //.padding(4)
                                            //.shadow(color: .secondary, radius: 2, x: 4, y: 6)
                                        
                                            .overlay {
                                            VStack {
                                                Text(chat.request)
                                                    .font(.callout)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.white)
                                                    .lineLimit(1)
                                                    .padding(.horizontal, 4)

                                                Text(chat.date, format: .dateTime.month().day().year())
                                                    .font(.caption2)
                                                    .foregroundColor(.white.opacity(0.7))
                                                    .padding(.bottom,6)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 6)
                                            .frame(maxWidth: .infinity)
                                            .background(LinearGradient(colors: [.gray, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                                            .offset(y: 72)
                                        }
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(radius: 7)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 15)
//                                            .stroke(lineWidth: 2)
//
//                                    )
                                }
                                .environmentObject(savedChats)

                            }
                        }
                        .padding([.horizontal, .bottom, .top])
                        
                    }
                    .padding(.horizontal, -16)
                    .navigationTitle("Ask DALL·E")
                }
            }
        }
    }
}
    
    struct DALLEMainView_Previews: PreviewProvider {
        static var previews: some View {
            DALLEMainView()
                .environmentObject(SavedChats())
            
        }
    }
