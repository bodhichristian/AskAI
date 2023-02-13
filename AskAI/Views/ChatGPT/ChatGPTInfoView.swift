//
//  ChatGPTInfoView.swift
//  OpenAIProject
//
//  Created by christian on 2/11/23.
//

import SwiftUI

struct ChatGPTInfoView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                davinciInfo
                curieInfo
                babbageInfo
                adaInfo

            }
            .navigationTitle("ChatGPT Info")
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

struct ChatGPTInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ChatGPTInfoView()
    }
}

extension ChatGPTInfoView {
    
    // Davinci engine overview
    private var davinciInfo: some View {
        Section {
            VStack {
                CircleImage(imageName: "davinci", width: 200, height: 200)
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
    
    // Curie engine overview
    private var curieInfo: some View {
        Section {
            VStack {
                CircleImage(imageName: "curie", width: 200, height: 200)
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
    
    // Babbage engine overview
    private var babbageInfo: some View {
        Section {
            VStack {
                CircleImage(imageName: "babbage", width: 200, height: 200)
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
    
    // Ada engine overview
    private var adaInfo: some View {
        Section {
            VStack {
                CircleImage(imageName: "ada", width: 200, height: 200)
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
}
