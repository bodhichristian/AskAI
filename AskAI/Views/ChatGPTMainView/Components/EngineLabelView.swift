//
//  EngineLabelView.swift
//  OpenAIProject
//
//  Created by christian on 1/27/23.
//

import SwiftUI

struct EngineLabelView: View {
    let engine: Engine
    
    var body: some View {
        Label {
            VStack(alignment: .leading) {
                Text(engine == .DALLE
                     ? "Ask DALL·E"
                     : "Ask \(engine.name.capitalizeFirst())")
                    .font(.headline)
                Text(engine.description)
                    .font(.caption)
                    .italic()
                    .foregroundColor(engine.color)
            }
            .padding(.leading, 45)
        } icon: {
            Image(engine.name)
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
                EngineLabelView(engine: .davinci)
                EngineLabelView(engine: .curie)
            }
        }
    }
}
