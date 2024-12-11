//
//  Font.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import SwiftUI

enum FontType: String {
  // MARK: - Avenir Next
  case avenirDemi = "AvenirNext-Demi"
  case avenirMedium = "AvenirNext-Medium"
  case avenirRegular = "AvenirNext-Regular"

  // MARK: - Circular Std
  case circularBold = "CircularStd-Bold"
  case circularMedium = "CircularStd-Medium"
  case circularBook = "CircularStd-Book"

  // MARK: - Montserrat
  case montserratRegular = "Montserrat-Regular"
}

extension Font {
  static func custom(type: FontType, size: CGFloat) -> Font {
    return Font.custom(type.rawValue, size: size)
  }
}
