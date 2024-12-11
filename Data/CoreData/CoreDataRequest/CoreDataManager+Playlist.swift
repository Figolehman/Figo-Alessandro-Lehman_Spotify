//
//  CoreDataManager+Playlist.swift
//  Data
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//


import CoreData
import Domain
import RxSwift

protocol CoreDataPlaylist {
  func getPlaylists() -> Observable<[Playlist]>
  func addPlaylist(playlist: Playlist) -> Bool
}

extension CoreDataManager: CoreDataPlaylist {
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
    let playlistEntity = playlist.toCoreDataEntity()
    save()
    return true
  }
}

