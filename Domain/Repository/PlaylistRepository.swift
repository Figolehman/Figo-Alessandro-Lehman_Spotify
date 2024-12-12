//
//  PlaylistRepository.swift
//  Domain
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import RxSwift

public protocol PlaylistRepository {
  func getPlaylists() -> Observable<[Playlist]>
  func addPlaylist(playlist: Playlist) -> Bool
  func getPlaylist(id: String) -> Observable<Playlist?>
  func addSongToPlaylist(song: Song, playlistID: String) -> Bool
  func removeSongFromPlaylist(song: Song, playlistID: String) -> Bool
}
