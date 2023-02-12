//
//  ThemePicker.swift
//  OpenAIProject
//
//  Created by christian on 2/11/23.
//

import SwiftUI

struct ThemePicker: View {
    // communicates changes to theme within the theme picker back up to parent view
    @Binding var selection: UsernameTheme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(UsernameTheme.allCases) { theme in
                ThemeView(theme: theme)
                    // tagging subview to differentiate in picker
                    .tag(theme)
            }
        }
        .pickerStyle(.wheel)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        // creates a binding to an immutable value for preview
        ThemePicker(selection: .constant(.mint))
    }
}
