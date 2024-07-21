//
//  VariationViewModel.swift
//  PlaygroundStyle
//
//  Created by alfian on 21/07/24.
//

import UIKit

class VariationViewModel: ObservableObject {
  @Published var backgroundWeak: UIColor
  @Published var textStrong: UIColor
  @Published var borderStrong: UIColor
  @Published var topContrastRatio: [UIColor] = []
  let colors: [UIColor]
  
  init(colors: [UIColor]) {
    self.colors = colors
    self.backgroundWeak = colors[0]
    self.textStrong = colors[colors.count-2]
    self.borderStrong = colors[colors.count-3]
    
    colors.forEach { color in
      if let contrastRatio = colors.first?.contrastRatio(with: color), contrastRatio >= WCAGLevel.AA.level {
        self.topContrastRatio.append(color)
      }
      
      if let contrastRatio = colors.last?.contrastRatio(with: color), contrastRatio >= WCAGLevel.AA.level {
        self.topContrastRatio.append(color)
      }
    }
  }
  
  func getForground(with backgroundColor: UIColor) -> UIColor {
    var index: Int = 0
    var maxRatio: CGFloat = 0
    
    for (offset, color) in colors.enumerated() {
      let ratio = color.contrastRatio(with: backgroundColor)
      if maxRatio < ratio && offset <= colors.count-3 {
        index = offset
        maxRatio = ratio
      }
    }
    
    return colors[index]
  }
}
