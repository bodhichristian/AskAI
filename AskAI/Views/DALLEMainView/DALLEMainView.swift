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
                Section(header: Text("Create an Image with AI")) {
                    NavigationLink {
                        DALLEPromptView(viewModel: dallEVM, engine: .DALLE)
                    } label: {
                        EngineLabelView(engine: .DALLE)
                    }
                }
                

            }
            .navigationTitle("Ask DALL·E")
        }
    }
}

struct DALLEMainView_Previews: PreviewProvider {
    static var previews: some View {
        DALLEMainView()
    }
}
