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
    case addPlaylistSong(playlist: Playlist, playlistVM: PlaylistViewModel)

    var id: Int {
      switch self {
      case .playlistDetail:
        return 0
      case .addPlaylistSong:
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
      if case let .addPlaylistSong(rhsPlaylist, _) = rhs,
         case let .addPlaylistSong(lhsPlaylist, _) = lhs,
         lhsPlaylist.id == rhsPlaylist.id {
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
    case .addPlaylistSong(let playlist, _):
      hasher.combine(self.id)
      hasher.combine(playlist.id)
    }
  }
}
