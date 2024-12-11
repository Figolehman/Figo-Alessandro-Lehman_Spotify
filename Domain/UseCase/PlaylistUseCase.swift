//
//  PlaylistUseCase.swift
//  Domain
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import RxSwift

public struct PlaylistUseCase {
  private let repository: PlaylistRepository

  public init(repository: PlaylistRepository) {
    self.repository = repository
  }

  public func getPlaylists() -> Observable<[Playlist]> {
    repository.getPlaylists()
  }

  public func addPlaylist(playlist: Playlist) -> Bool {
    repository.addPlaylist(playlist: playlist)
  }
}

