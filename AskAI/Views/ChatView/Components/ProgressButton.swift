//
//  ProgressButton.swift
//  ProgressButton
//
//  Created by christian on 2/1/23.
//
//  Adapted from SliderButtonView by Polina Belovodskaya
//  https://github.com/PollyVern/SwiftUI-Animations
//

import SwiftUI

struct ProgressButton: View {
    
    // Observes the viewModel for completion
    @ObservedObject var viewModel: OpenAIViewModel
    let engine: Engine
    @State var baseHeight: CGFloat = 50

    enum ProgressButtonTypes: CaseIterable {
        case submit
        case inProgress
        case complete
        
        // ProgressButton label
        var title: String {
            switch self {
            case .submit:
                return "Submit"
            case .inProgress:
                return "Waiting for response..."
            case .complete:
                return "Response received."
            }
        }
    }

    var body: some View {
        ZStack {
            Button {
                hideKeyboard()
                viewModel.inProgress = true
                if engine == .DALLE {
                    Task {
                        await viewModel.generateImage(prompt: viewModel.imagePrompt)
                    }
                } else {
                    Task {
                        await viewModel.submitRequest(viewModel.request, engine: engine)
                    }
                }
            } label: {
                VStack(spacing: 0) {
                    baseInternalView(type: .complete)
                    baseInternalView(type: .inProgress)
                    baseInternalView(type: .submit)
                    Spacer()
                        .frame(height: baseHeight * 2)
                }
                .frame(height: baseHeight * CGFloat(ProgressButtonTypes.allCases.count))
                .mask(
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: baseHeight)
                )
            }
            .disabled(viewModel.request == "" || viewModel.inProgress || viewModel.complete)
        }
    }

    private func baseInternalView(type: ProgressButtonTypes) -> some View {
        ZStack {
            Rectangle()
                .fill(viewModel.request == "" ? .secondary.opacity(0.5) : engine.color)
                .frame(height: 50)
            Text(type.title)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium, design: .default))
                .shadow(radius: 6)
        }
        .frame(height: 50)
        .offset(y: viewModel.inProgress ? baseHeight : 0)
        .animation(.spring(), value: viewModel.inProgress)

        .offset(y: viewModel.complete ? baseHeight : 0)
        .animation(.spring(), value: viewModel.complete)
    }

}

struct SliderButton_Previews: PreviewProvider {
    static var previews: some View {
        ProgressButton(viewModel: OpenAIViewModel.example, engine: .davinci)
    }
}
