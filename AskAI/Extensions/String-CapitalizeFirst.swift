//
//  String-ProperNoun.swift
//  OpenAIProject
//
//  Created by christian on 1/28/23.
//

import Foundation

extension String {
    
    func capitalizeFirst() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}
