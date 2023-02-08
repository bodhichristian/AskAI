//
//  DALLEMainView.swift
//  OpenAIProject
//
//  Created by christian on 2/8/23.
//

import SwiftUI

struct DALLEMainView: View {
    @StateObject var dallEVM = OpenAIViewModel()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    DALLEPromptView(viewModel: dallEVM, engine: .DALLE)
                } label: {
                    Text("DALL-E")
                }

            }
        }
    }
}

struct DALLEMainView_Previews: PreviewProvider {
    static var previews: some View {
        DALLEMainView()
    }
}
