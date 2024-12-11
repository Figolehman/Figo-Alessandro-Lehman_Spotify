//
//  CustomWebImage.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import SwiftUI
import SDWebImageSwiftUI

enum PlaceholderType {
  case song
  case none

  var image: ImageResource? {
    switch self {
    case .song:
      return .imgPlaceholderSong
    case .none:
      return nil
    }
  }
}

struct CustomWebImage: View {
  let urlImage: String
  var aspectRatio: CGFloat? = nil
  var contentMode: ContentMode = .fill
  var width: CGFloat? = nil
  var height: CGFloat? = nil
  var useLocalCache = false
  var placeholder: PlaceholderType

  init(urlImage: String, aspectRatio: CGFloat? = nil, contentMode: ContentMode = .fill, width: CGFloat? = nil, height: CGFloat? = nil, useLocalCache: Bool = false, placeholder: PlaceholderType = .none) {
    self.urlImage = urlImage
    self.aspectRatio = aspectRatio
    self.contentMode = contentMode
    self.width = width
    self.height = height
    self.useLocalCache = useLocalCache
    self.placeholder = placeholder
  }

  var body: some View {
    if let url = URL(string: urlImage) {
      WebImage(
        url: url,
        content: { image in
          image
            .resizable()
        },
        placeholder: {
          if let image = placeholder.image {
            Image(image)
              .resizable()
          }
        })
      .aspectRatio(aspectRatio, contentMode: .fill)
      .frame(width: width, height: height)
    } else {
      if let image = placeholder.image {
        Image(image)
          .resizable()
          .aspectRatio(aspectRatio, contentMode: .fill)
          .frame(width: width, height: height)
      }
    }
  }
}
