//
//  View-HideKeyboard.swift
//  OpenAIProject
//
//  Created by christian on 2/2/23.
//

import Foundation
import SwiftUI
import UIKit

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
