//
//  CircleImage.swift
//  OpenAIProject
//
//  Created by christian on 1/27/23.
//

import SwiftUI

struct CircleImage: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: width)
                .foregroundColor(.white)
                .shadow(color: .secondary, radius: 4)
            Image(imageName)
                .resizable()
                .frame(width: width, height: height)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 1))
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            CircleImage(imageName: "davinci", width: 80, height: 80)
            CircleImage(imageName: "curie", width: 80, height: 80)
            CircleImage(imageName: "babbage", width: 80, height: 80)
            CircleImage(imageName: "ada", width: 80, height: 80)
        }
    }
}
