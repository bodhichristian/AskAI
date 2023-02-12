//
//  TotalRequestCounter.swift
//  OpenAIProject
//
//  Created by christian on 2/11/23.
//

import Foundation

class TotalRequests: ObservableObject {
    @Published var count: Int
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("TotalRequests")
    
    init() {
        //looks in documentsDirectory for stored data
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(Int.self, from: data) {
                count = decoded
                print("TotalRequests.count decoded")
                return
            }
        }
        // If no data is in DocumentsDirectory, count is 0
        print("No data found in Documents Directory")
        count = 0
    }
    
    func increase(by: Int) {
        count += 1
        save()
        
    }
    
    private func save() {
        // Saves the current TotalRequests to DocumentsDirectory
        if let encoded = try? JSONEncoder().encode(count) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Total Requests Saved.")
        }
    }
 
}
