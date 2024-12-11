//
//  LibraryRouter.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import SwiftUI

final class LibraryRouter: ObservableObject {

  public enum Destination {
    case playlistDetail(playlist: Playlist)
    case addPlaylistSong(playlistID: String)

    var id: Int {
      switch self {
      case .playlistDetail(let playlist):
        return 0
      case .addPlaylistSong(let playlistID):
        return 1
      }
    }
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

extension LibraryRouter.Destination: Hashable {
  static func == (lhs: LibraryRouter.Destination, rhs: LibraryRouter.Destination) -> Bool {
    if lhs.id == rhs.id {
      if case let .addPlaylistSong(rhsId) = lhs,
         case let .addPlaylistSong(lhsId) = rhs,
         lhsId == rhsId {
        return true
      } else if case let .playlistDetail(lhsPlaylist) = lhs,
                case let .playlistDetail(rhsPlaylist) = rhs,
                lhsPlaylist.id == rhsPlaylist.id {
        return true
      }
    }
    return false
  }

  public func hash(into hasher: inout Hasher) {
    switch self {
    case .playlistDetail(let playlist):
      hasher.combine(self.id)
      hasher.combine(playlist.id)
    case .addPlaylistSong(let playlistID):
      hasher.combine(self.id)
      hasher.combine(playlistID)
    }
  }
}
