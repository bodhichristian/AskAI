//
//  ChatGPTService.swift
//  OpenAIProject
//
//  Created by christian on 1/21/23.
//

//import Foundation
//import Combine
//
//class ChatGPTService {
//    @Published var response: String = ""
//    var chatGPTSubscription: AnyCancellable?
//
//    var request: String
//
//    init(response: String, chatGPTSubscription: AnyCancellable? = nil, request: String) {
//        self.response = response
//        self.chatGPTSubscription = chatGPTSubscription
//        self.request = request
//    }
//
//    func getResponse() {
//
//        DispatchQueue.main.async {
//            Task {
//                do {
//                    let result = try await openAI.sendCompletion(with: self.request, maxTokens: 500)
//                    self.response = result.choices.first?.text ?? ""
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//}
