//
//  View.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import SwiftUI

extension View {
  func getWidth(_ width: Binding<CGFloat>) -> some View {
    self
      .background(
        GeometryReader { geo -> Color in
          DispatchQueue.main.async {
            width.wrappedValue = geo.size.width
          }

          return Color.clear
        }
      )
  }

  func getHeight(_ height: Binding<CGFloat>) -> some View {
    self
      .background(
        GeometryReader { geo -> Color in
          DispatchQueue.main.async {
            height.wrappedValue = geo.size.height
          }

          return Color.clear
        }
      )
  }

  func font(_ fontName: FontType, fontSize: CGFloat, lineHeight: CGFloat) -> some View {
    self
      .font(Font.custom(type: fontName, size: fontSize))
      .lineSpacing(lineHeight - UIFont(name: fontName.rawValue, size: fontSize)?.lineHeight ?? fontSize)
      .padding(.vertical, (lineHeight - UIFont(name: fontName.rawValue, size: fontSize)?.lineHeight ?? fontSize) / 2)
  }
}
