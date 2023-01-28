//
//  CircleImage.swift
//  OpenAIProject
//
//  Created by christian on 1/27/23.
//

import SwiftUI

struct CircleImage: View {
    @State var engine: String
    @State var width: CGFloat
    @State var height: CGFloat
    
    var body: some View {
        Image(engine)
            .resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
            .overlay(Circle().stroke(.white, lineWidth: 1))
            .shadow(color: .secondary, radius: 3)
            .padding(.leading, 35)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            CircleImage(engine: "davinci", width: 80, height: 80)
            CircleImage(engine: "curie", width: 80, height: 80)
            CircleImage(engine: "babbage", width: 80, height: 80)
            CircleImage(engine: "ada", width: 80, height: 80)
        }
    }
}
