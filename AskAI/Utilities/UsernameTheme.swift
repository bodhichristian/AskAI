//
//  Theme.swift
//  OpenAIProject
//
//  Created by christian on 2/11/23.
//


import SwiftUI

enum UsernameTheme: String, CaseIterable, Identifiable, Codable {
    case blue
    case purple
    case mint
    case pink
    case green
    
    var accentColor: Color {
        switch self {
        case .mint: return .black
        default: return .white
        }
    }
    
    var mainColor: Color {
        switch self {
        case .mint: return .mint
        case .purple: return .purple
        case .blue: return .blue
        case .green: return .green
        case .pink: return Color(red: 1, green: 0.2, blue: 0.6)
        }
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
