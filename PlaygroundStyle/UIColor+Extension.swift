//
//  UIColor+Extension.swift
//  PlaygroundStyle
//
//  Created by alfian on 21/07/24.
//

import UIKit

extension UIColor: Identifiable {}

extension UIColor {
  convenience init(hex: String) {
    let hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)
    
    if hexString.hasPrefix("#") {
        scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
    }
    
    var color: UInt64 = 0
    scanner.scanHexInt64(&color)
    
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    
    let red   = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue  = CGFloat(b) / 255.0
    
    self.init(red: red, green: green, blue: blue, alpha: 1)
  }
  
  func toHexString() -> String? {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    guard self.getRed(&r, green: &g, blue: &b, alpha: &a) else {
        return nil
    }
    
    let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
    return String(format: "#%06x", rgb)
  }
}

extension UIColor {
  func getHSVComponents() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)? {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0
    
    let success = self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    return success ? (hue, saturation, brightness, alpha) : nil
  }
}

extension UIColor {
    func adjust(by percentage: CGFloat) -> UIColor? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
    func darker(by percentage: CGFloat) -> UIColor? {
        return self.adjust(by: -percentage)
    }
    
    func lighter(by percentage: CGFloat) -> UIColor? {
        return self.adjust(by: percentage)
    }
}


extension UIColor {
    private func linearizeComponent(_ component: CGFloat) -> CGFloat {
        return component <= 0.03928 ? (component / 12.92) : pow((component + 0.055) / 1.055, 2.4)
    }

    private var luminance: CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let linearRed = linearizeComponent(red)
        let linearGreen = linearizeComponent(green)
        let linearBlue = linearizeComponent(blue)

        return 0.2126 * linearRed + 0.7152 * linearGreen + 0.0722 * linearBlue
    }

    func contrastRatio(with color: UIColor) -> CGFloat {
        let luminance1 = self.luminance
        let luminance2 = color.luminance

        return luminance1 > luminance2
            ? (luminance1 + 0.05) / (luminance2 + 0.05)
            : (luminance2 + 0.05) / (luminance1 + 0.05)
    }

    func isContrastSufficient(with color: UIColor, level: WCAGLevel) -> Bool {
      let ratio = self.contrastRatio(with: color)
      return ratio >= level.level
    }
}

enum WCAGLevel {
    case AA
    case AAA
    case AALarge
  
  var level: CGFloat {
    switch self {
    case .AA:
      return 4.5
    case .AAA:
      return 7.0
    case .AALarge:
      return 30
    }
  }
}
