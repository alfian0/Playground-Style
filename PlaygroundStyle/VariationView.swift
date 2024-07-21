//
//  VariationView.swift
//  PlaygroundStyle
//
//  Created by alfian on 21/07/24.
//

import SwiftUI

struct VariationView: View {
  let colors: [UIColor]
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(colors) { color in
          ZStack {
            Rectangle()
              .fill(Color(color))
              .frame(height: 50)
            
            Text(color.toHexString() ??  "")
              .foregroundColor(Color(getForground(with: color)))
          }
        }
      }
      .padding()
      
      ZStack {
        Color(colors.first!)
          .cornerRadius(8)
        
        VStack(alignment: .leading, spacing: 8) {
          Text("Sample Title")
            .foregroundColor(Color(colors.last!))
            .font(.headline)
          
          Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
            .foregroundColor(Color(colors.last!))
            .font(.body)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
      }
      .padding(16)
      
      VStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color(colors[1]), lineWidth: 1)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
            .frame(height: 44)
        
        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
          .foregroundColor(Color(colors[1]))
          .font(.caption)
      }
      .padding(16)
    }
  }
  
  func getForground(with backgroundColor: UIColor) -> UIColor {
    var index: Int = 0
    var maxRatio: CGFloat = 0
    
    for (offset, color) in colors.enumerated() {
      let ratio = color.contrastRatio(with: backgroundColor)
      if maxRatio < ratio && offset <= 8 {
        index = offset
        maxRatio = ratio
      }
    }
    
    return colors[index]
  }
}

struct VariationView_Previews: PreviewProvider {
    static var previews: some View {
      VariationView(colors: [
        UIColor(hex: "#ffd3d3"),
        UIColor(hex: "#ae2020"),
        UIColor(hex: "#940606")
      ])
    }
}
