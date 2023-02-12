//
//  DALLEInfoView.swift
//  OpenAIProject
//
//  Created by christian on 2/11/23.
//

import SwiftUI

struct DALLEInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    // When showingInfoView is toggled, a modal sheet will present
    @State private var showingInfoView = false
    
    var body: some View {
        NavigationView {
            List {
                dallEInfo
            }
            .navigationTitle("DALL·E Info")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            })
        }
    }
}

struct DALLEInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DALLEInfoView()
    }
}

extension DALLEInfoView {
    private var dallEInfo: some View {
        Section {
            VStack {
                CircleImage(imageName: "dallE", width: 200, height: 200)
                    .padding(5)

                Text("DALL·E 2 can create original, realistic images and art from a text description. It can combine concepts, attributes, and styles. DALL·E 2, generates more realistic and accurate images with 4x greater resolution than its predecessor.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
            }
        } header: {
            Text("DALL·E 2")
                .bold()
                .foregroundColor(.blue)
        }
    }
}
