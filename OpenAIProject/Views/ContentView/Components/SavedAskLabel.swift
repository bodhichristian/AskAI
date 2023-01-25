//
//  SavedAskLabel.swift
//  OpenAIProject
//
//  Created by christian on 1/24/23.
//

import SwiftUI

struct SavedAskLabel: View {
    @State var request: String
    @State var response: String
    @State var image: String
    @State var date: Date
    
    let formatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(request)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                    .lineLimit(1)
                
            }
            Text(date, format: .dateTime.month().day().year())
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
            HStack(alignment: .center) {
                    ZStack {
                        Circle()
                            .frame(width: 30)
                            .foregroundColor(.white)
                            .shadow(color: .secondary, radius: 2)
                        Image(image)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                Text(response.trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.subheadline)
                        .lineLimit(3)
                    
                
            }
            
            
            
        }
    }
}

struct SavedAskLabel_Previews: PreviewProvider {
    static var previews: some View {
        SavedAskLabel(request: "This is a test request", response: "Wowee wow wow this is a test response. Sometimes they are super long, sometimes they aren't all that lengthy.", image: "ChatGPT", date: Date.now)
    }
}
