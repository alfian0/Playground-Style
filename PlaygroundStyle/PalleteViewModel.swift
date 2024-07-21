//
//  PalleteViewModel.swift
//  PlaygroundStyle
//
//  Created by alfian on 21/07/24.
//

import UIKit

class PalleteViewModel: ObservableObject {
  enum Secondary: CaseIterable {
    case yellow
    case green
    case red
    case blue
    case gray
    
    var hue: CGFloat? {
      switch self {
      case .yellow:
        return 60/360
      case .green:
        return 120/360
      case .red:
        return 0/360
      case .blue:
        return 210/360
      default:
        return nil
      }
    }
    
    var saturation: CGFloat? {
      switch self {
      case .gray:
        return 0.1
      default:
        return nil
      }
    }
  }
  @Published var colors: [UIColor] = []
  
  init(baseColor: UIColor) {
    colors.append(baseColor)
    generateColors()
  }
  
  func generateColors() {
    guard let hsv = colors.first?.getHSVComponents() else {
      return
    }
    
    Secondary.allCases.forEach { value in
      let saturation = value.saturation ?? hsv.saturation
      colors.append(UIColor(hue: value.hue ?? hsv.hue, saturation: min(saturation, 0.7), brightness: hsv.brightness, alpha: hsv.alpha))
    }
  }
  
  func getForground(with backgroundColor: UIColor) -> UIColor {
    var index: Int = 0
    var maxRatio: CGFloat = 0
    
    let colors = [UIColor.white, UIColor.black]
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
