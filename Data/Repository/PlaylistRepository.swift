//
//  PlaylistRepository.swift
//  Data
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import RxSwift

public struct DefaultPlaylistRepository: PlaylistRepository {
  private let localDataSource: PlaylistLocalDataSource

  public init(localDataSource: PlaylistLocalDataSource) {
    self.localDataSource = localDataSource
  }

  public func getPlaylists() -> Observable<[Playlist]> {
    localDataSource.getPlaylists()
  }

  public func getPlaylist(id: String) -> Observable<Playlist?> {
    localDataSource.getPlaylist(id: id)
  }

  public func addPlaylist(playlist: Playlist) -> Bool {
    localDataSource.addPlaylist(playlist: playlist)
  }

  public func addSongToPlaylist(song: Song, playlistID: String) -> Bool {
    localDataSource.addSongToPlaylist(song: song, playlistID: playlistID)
  }
}
