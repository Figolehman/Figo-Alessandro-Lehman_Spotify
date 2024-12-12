//
//  CoreDataManager+Playlist.swift
//  Data
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//


import CoreData
import Domain
import RxSwift

extension CoreDataManager {
  func getPlaylists() -> Observable<[Playlist]> {
    let subject = ReplaySubject<[Playlist]>.createUnbounded()
    let request = NSFetchRequest<PlaylistEntity>(entityName: "PlaylistEntity")

    do {
      subject.onNext(try context.fetch(request).map { $0.toDomain() })
    } catch {
      subject.onError(error)
    }

    return subject
  }

  func addPlaylist(playlist: Playlist) -> Bool {
    playlist.toCoreDataEntity()
    save()
    return true
  }

  func addSongToPlaylist(song: Song, playlistID: String) -> Bool {
    guard let playlist = getExistingPlaylist(id: playlistID) else { return false }
    if let existingSong = getExistingSong(song) {
      existingSong.addToPlaylists(playlist)
      playlist.songs?.adding(existingSong)
    } else {
      let songEntity = song.toCoreDataEntity()
      songEntity.addToPlaylists(playlist)
    }
    save()
    return true
  }

  func removeSongFromPlaylist(song: Song, playlistID: String) -> Bool {
    guard let playlist = getExistingPlaylist(id: playlistID) else { return false }
    if let existingSong = getExistingSong(song) {
      existingSong.removeFromPlaylists(playlist)
      save()
    }
    return true
  }

  func getExistingPlaylist(id: String) -> PlaylistEntity? {
    let request = NSFetchRequest<PlaylistEntity>(entityName: "PlaylistEntity")
    request.predicate = NSPredicate(format: "id == %@", id)

    do {
      return try context.fetch(request).first
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }

  func getExistingPlaylist(id: String) -> Observable<Playlist?> {
    let subject = ReplaySubject<Playlist?>.createUnbounded()
    let request = NSFetchRequest<PlaylistEntity>(entityName: "PlaylistEntity")
    request.predicate = NSPredicate(format: "id == %@", id)

    do {
      let playlist = try context.fetch(request).first
      subject.onNext(playlist?.toDomain())
    } catch {
      print(error.localizedDescription)
      subject.onError(error)
    }

    return subject
  }
}

