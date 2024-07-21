//
//  LuminanceView.swift
//  PlaygroundStyle
//
//  Created by alfian on 21/07/24.
//

import SwiftUI

struct LuminanceView: View {
  @ObservedObject private var viewModel: LuminanceViewModel
  
  init(viewModel: LuminanceViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationLink {
      VariationView(colors: [viewModel.colors[0], viewModel.colors[8], viewModel.colors[9]])
    } label: {
      ScrollView {
        VStack(spacing: 0) {
          ForEach(viewModel.colors) { color in
            ZStack {
              Rectangle()
                .fill(Color(color))
                .frame(height: 50)
              
              Text("\(color.toHexString() ?? "") (\(viewModel.getForground(with: color).contrastRatio(with: color)))")
                .foregroundColor(Color(viewModel.getForground(with: color)))
            }
          }
        }
        .padding()
      }
      .navigationTitle(viewModel.colors[viewModel.colors.count/2].toHexString() ?? "")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct LuminanceView_Previews: PreviewProvider {
    static var previews: some View {
      LuminanceView(viewModel: LuminanceViewModel(baseColor: UIColor(hex: "#806DFB")))
    }
}
