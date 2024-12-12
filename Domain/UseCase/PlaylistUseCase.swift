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

  public func getPlaylist(id: String) -> Observable<Playlist?> {
    repository.getPlaylist(id: id)
  }

  public func addPlaylist(playlist: Playlist) -> Bool {
    repository.addPlaylist(playlist: playlist)
  }

  public func addSongToPlaylist(song: Song, playlistID: String) -> Bool {
    repository.addSongToPlaylist(song: song, playlistID: playlistID)
  }
}

