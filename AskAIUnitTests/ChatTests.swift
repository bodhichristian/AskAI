//
//  AskAITests.swift
//  AskAITests
//
//  Created by christian on 3/8/23.
//

import XCTest
import Combine
@testable import AskAI

final class ChatTests: XCTestCase {
    // Test initialization
    func test_initialization_valuesAssigned() throws {
        let chat1 = Chat(
            request: "Test request",
            response: "Test response",
            engine: .davinci,
            isFavorite: true)
        XCTAssertEqual(chat1.request, "Test request")
        XCTAssertEqual(chat1.response, "Test response")
        XCTAssertEqual(chat1.engine, .davinci)
        XCTAssertTrue(chat1.isFavorite)
        
    }
    
    // Test Codable conformance
    func test_chatEncodingAndDecoding_chatsSaveAndLoad() throws {
        let chat = Chat(request: "Test Request", response: "Test Response", engine: .davinci)
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(chat)
        
        let decoder = JSONDecoder()
        let decodedChat = try decoder.decode(Chat.self, from: data)
        
        XCTAssertEqual(chat.id, decodedChat.id)
        XCTAssertEqual(chat.request, decodedChat.request)
        XCTAssertEqual(chat.response, decodedChat.response)
        XCTAssertEqual(chat.date, decodedChat.date)
        XCTAssertEqual(chat.engine, decodedChat.engine)
        XCTAssertEqual(chat.generatedImage, decodedChat.generatedImage)
        XCTAssertEqual(chat.isFavorite, decodedChat.isFavorite)
    }
    
    // Test ChatGPT Example Chat for previews
    func test_chatGPTExample_isValidChat() throws {
        let chat = Chat.chatGPTExample
        XCTAssertEqual(chat.request, "This is a really interesting chat request example")
        XCTAssertEqual(chat.response, "This response example is, inconceivably so, even more interesting than the request.")
        XCTAssertEqual(chat.engine, .davinci)
        XCTAssertTrue(chat.isFavorite)
    }
    // Test DALL·E Example Chat for previews
    func test_dallEExample_isValidChat() throws {
        let chat = Chat.dallEExample
        XCTAssertEqual(chat.request, "twitter bird example")
        XCTAssertEqual(chat.engine, .DALLE)
        XCTAssertEqual(chat.generatedImage, UIImage(named: "twitter")!.pngData())
    }
    
    // Test ObservableObject functionality
    func test_observableObject_propertyPublishing() {
        let chat = Chat(request: "Hello", response: "Hi", engine: .davinci)
        
        // Test isFavorite property can be set and its value changes when using @Published
        var cancellables = Set<AnyCancellable>()
        let expectation1 = expectation(description: "isFavorite should be true")
        chat.$isFavorite.sink { newValue in
            if newValue == true {
                expectation1.fulfill()
            }
        }.store(in: &cancellables)
        chat.isFavorite = true
        wait(for: [expectation1], timeout: 1.0)
        XCTAssertTrue(chat.isFavorite)
        
        // Test changing isFavorite property triggers an objectWillChange publisher event
        let expectation2 = expectation(for: NSPredicate(block: { _, _ in
            return true
        }), evaluatedWith: chat, handler: nil)
        chat.isFavorite = false
        wait(for: [expectation2], timeout: 1.0)
    }
}





