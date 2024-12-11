//
//  LibraryRouter.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import SwiftUI

final class LibraryRouter: ObservableObject {

  public enum Destination: Codable, Hashable {
    case playlistDetail(id: String)
    case addPlaylistSong(playlistID: String)
  }

  @Published var navPath = NavigationPath()

  func navigate(to destination: Destination) {
    navPath.append(destination)
  }

  func navigateBack() {
    if navPath.count > 0 {
      navPath.removeLast()
    }
  }

  func navigateToRoot() {
    navPath = NavigationPath()
  }
}
