//
//  Theme.swift
//  OpenAIProject
//
//  Created by christian on 2/11/23.
//


import SwiftUI

enum UserTheme: String, CaseIterable, Identifiable, Codable {
    case blue
    case red
    case mint
    case pink
    case green
    case purple
    case orange
    case indigo
    case yellow
    
    // Text color
    var accentColor: Color {
        switch self {
        case .mint, .yellow, .orange, .green, .blue: return .black
        default: return .white
        }
    }
    
    // Theme color
    var mainColor: Color {
        switch self {
        case .mint: return .mint
        case .purple: return .purple
        case .blue: return .blue
        case .green: return .green
        case .pink: return Color(red: 1, green: 0.2, blue: 0.6)
        case .orange: return .orange
        case .red: return .red
        case .yellow: return .yellow
        case .indigo: return .indigo
            
        }
    }
    
    // Theme name
    var name: String {
        rawValue.capitalized
    }
    
    // Theme id
    // Used to uniquely identify cases for Picker in SettingsView
    var id: String {
        name
    }
}
