//
//  CircleButton.swift
//  OpenAIProject
//
//  Created by christian on 1/30/23.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: "line.3.horizontal")
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.secondary)
            )
            .shadow(
                color: .secondary.opacity(0.5), radius: 10
            )
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
