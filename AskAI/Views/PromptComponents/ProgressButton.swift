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
    @ObservedObject var totalRequests: TotalRequests
    
    let engine: Engine

    enum ProgressButtonTypes: CaseIterable {
        case submit
        case inProgress
        case complete
        
        // ProgressButton label
        var buttonLabel: String {
            switch self {
            case .submit:
                // Default label
                return "Submit"
            case .inProgress:
                // In Progress label
                return "Waiting for response..."
            case .complete:
                // Completed label
                return "Response received."
            }
        }
    }
    
    @State private var baseHeight: CGFloat = 50

    var body: some View {
        ZStack {
            Button {
                // Dismiss system keyboard
                hideKeyboard()
                // Add 1 to totalRequets
                totalRequests.increase(by: 1)
                // Change viewModel state to inProgress
                viewModel.inProgress = true
                // If requesting an image
                if engine == .DALLE {
                    Task {
                        // Await image response
                        await viewModel.generateImage(prompt: viewModel.request)
                    }
                    // If requesting text
                } else {
                    Task {
                        // Await text response
                        await viewModel.submitRequest(viewModel.request, engine: engine)
                    }
                }
            } label: {
                VStack(spacing: 0) {
                    // Three rounded rectangles representing task progress
                    // As each state is triggered, offset value changes
                    // Each button animates down on in front of the previous
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
        .padding(.vertical, -50)
    }
    // baseInternalView(type: ) handles presenting the correct view with the correct progress state
    private func baseInternalView(type: ProgressButtonTypes) -> some View {
        ZStack {
            Rectangle()
                .fill(viewModel.request == "" ? .secondary.opacity(0.5) : engine.color)
                .frame(height: 50)
            
            Text(type.buttonLabel)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium, design: .default))
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
        ProgressButton(viewModel: OpenAIViewModel.example, totalRequests: TotalRequests(), engine: .davinci)
    }
}
