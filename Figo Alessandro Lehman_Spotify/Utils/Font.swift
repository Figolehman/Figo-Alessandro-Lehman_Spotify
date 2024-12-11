//
//  Font.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import SwiftUI

enum FontType: String {
  // MARK: - Avenir Next
  case avenirBold = "AvenirNext-Bold"
  case avenirMedium = "AvenirNext-Medium"
  case avenirRegular = "AvenirNext-Regular"
}

extension Font {
  static func custom(type: FontType, size: CGFloat) -> Font {
    return Font.custom(type.rawValue, size: size)
  }
}
