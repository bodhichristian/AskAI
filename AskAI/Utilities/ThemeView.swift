//
//  ThemeView.swift
//  OpenAIProject
//
//  Created by christian on 2/11/23.
//

import SwiftUI

struct ThemeView: View {
    let theme: UsernameTheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Label(theme.name, systemImage: "person.circle")
                .font(.callout)
                .fontWeight(.semibold)
                .padding(4)
                .foregroundColor(theme.accentColor)
        }
        //.foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .mint)
    }
}
