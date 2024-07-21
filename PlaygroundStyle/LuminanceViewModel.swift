//
//  LuminanceViewModel.swift
//  PlaygroundStyle
//
//  Created by alfian on 21/07/24.
//

import UIKit

class LuminanceViewModel: ObservableObject {
  @Published var colors: [UIColor] = []
  
  init(baseColor: UIColor) {
    colors.append(baseColor)
    generateColors()
  }
  
  func generateColors() {
    let baseColor = colors.first ?? .white
    var colorPalette = [UIColor]()
    let increments: [CGFloat] = [1.0, 2.0, 3.0, 4.0, 5.0].reversed()
    
    for (_, increment) in increments.enumerated() {
        if let lighterColor = baseColor.lighter(by: increment * 10) {
          colorPalette.append(lighterColor)
        }
    }
      
    colorPalette.append(baseColor)
      
    for (_, increment) in increments.reversed().enumerated() {
        if let darkerColor = baseColor.darker(by: increment * 10) {
          colorPalette.append(darkerColor)
        }
    }
    
    colors = colorPalette
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
