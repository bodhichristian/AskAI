//
//  FileManager-DocumentsDirectory.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
