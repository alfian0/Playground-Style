//
//  VariationView.swift
//  PlaygroundStyle
//
//  Created by alfian on 21/07/24.
//

import SwiftUI

struct VariationView: View {
  @ObservedObject var viewModel: VariationViewModel
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        ZStack {
          Color(viewModel.backgroundWeak)
            .cornerRadius(8)
          
          VStack(alignment: .leading, spacing: 8) {
            Text("Sample Title")
              .foregroundColor(Color(viewModel.textStrong))
              .font(.headline)
            
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
              .foregroundColor(Color(viewModel.textStrong))
              .font(.body)
          }
          .padding(.horizontal, 24)
          .padding(.vertical, 16)
        }
        .padding(.horizontal, 16)
        
        VStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color(viewModel.borderStrong), lineWidth: 1)
              .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
              .frame(height: 44)
          
          Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
            .foregroundColor(Color(viewModel.borderStrong))
            .font(.caption)
        }
        .padding(.horizontal, 16)
        
        VStack(alignment: .leading) {
          Text("Top Contrast Ratio")
            .font(.headline)
          
          VStack(spacing: 0) {
            ForEach(viewModel.topContrastRatio) { color in
              NavigationLink {
                LuminanceView(viewModel: LuminanceViewModel(baseColor: color))
              } label: {
                ZStack {
                  Rectangle()
                    .fill(Color(color))
                    .frame(height: 50)
                  
                  Text(color.toHexString() ?? "")
                    .foregroundColor(Color(viewModel.getForground(with: color)))
                }
              }
            }
          }
        }
        .padding(.horizontal, 16)
      }
    }
  }
}

struct VariationView_Previews: PreviewProvider {
    static var previews: some View {
      VariationView(viewModel: VariationViewModel(colors: [
        UIColor(hex: "#806DFB"),
        UIColor(hex: "#000000"),
        UIColor(hex: "#ffffff"),
        UIColor(hex: "#000000")
      ]))
    }
}
