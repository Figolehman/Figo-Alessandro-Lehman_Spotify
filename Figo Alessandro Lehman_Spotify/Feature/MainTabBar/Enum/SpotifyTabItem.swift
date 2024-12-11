//
//  SpotifyTabBar.swift
//  Spotify Assigmnent
//
//  Created by Figo Alessandro Lehman on 06/12/24.
//

import SwiftUI

enum SpotifyTabItem: CaseIterable {
  case home, search, library

  var label: String {
    switch self {
    case .home:
      return AppString.lblTabBarHome
    case .search:
      return AppString.lblTabBarSearch
    case .library:
      return AppString.lblTabBarLibrary
    }
  }

  var icon: ImageResource {
    switch self {
    case .home:
      return .icHome
    case .search:
      return .icSearch
    case .library:
      return .icLibraryFill
    }
  }
}
