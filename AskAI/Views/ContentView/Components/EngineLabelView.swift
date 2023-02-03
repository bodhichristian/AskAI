//
//  EngineLabelView.swift
//  OpenAIProject
//
//  Created by christian on 1/27/23.
//

import SwiftUI

struct EngineLabelView: View {
    @State var engine: String
    
    private var engineName: String {
        switch engine {
        case "davinci": return "Davinci"
        case "curie": return "Curie"
        case "babbage": return "Babbage"
        default: return "Ada"
        }
    }
    
    private var accentColor: Color {
        switch engine {
        case "davinci": return .mint
        case "curie": return .purple
        case "babbage": return .green
        default: return Color(red: 3, green: 0.2, blue: 0.6)
        }
    }
    
    private var description: String {
        switch engine {
        case "davinci": return "Most capable"
        case "curie": return "Powerful, yet fast"
        case "babbage": return "Straightforward tasks"
        default: return "Fast and simple"
        }
    }
    
    var body: some View {
        Label {
            VStack(alignment: .leading) {
                Text("Ask \(engineName)")
                    .font(.headline)
                Text(description)
                    .font(.caption)
                    .italic()
                    .foregroundColor(accentColor)
            }
            .padding(.leading, 45)
        } icon: {
                Image(engine)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white, lineWidth: 0.8))
                    .shadow(color: .secondary, radius: 7)
                    .padding(.leading, 35)
        }
    }
}

struct EngineLabelView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                EngineLabelView(engine: "davinci")
                EngineLabelView(engine: "curie")
            }

        }
    }
}
