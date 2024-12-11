//
//  PlaylistLocalDataSource.swift
//  Data
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import RxSwift

public protocol PlaylistLocalDataSource {
  func getPlaylists() -> Observable<[Playlist]> 
  func addPlaylist(playlist: Playlist) -> Bool
  func addSongToPlaylist(song: Song, playlistID: String) -> Bool
}

public struct DefaultPlaylistlocalDataSource: PlaylistLocalDataSource {
  public init() {}

  public func getPlaylists() -> Observable<[Playlist]> {
    CoreDataManager.shared.getPlaylists()
  }

  public func addPlaylist(playlist: Playlist) -> Bool {
    CoreDataManager.shared.addPlaylist(playlist: playlist)
  }

  public func addSongToPlaylist(song: Song, playlistID: String) -> Bool {
    CoreDataManager.shared.addSongToPlaylist(song: song, playlistID: playlistID)
  }
}
