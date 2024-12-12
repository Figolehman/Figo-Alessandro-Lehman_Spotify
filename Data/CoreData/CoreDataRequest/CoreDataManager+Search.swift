//
//  CoreDataManager+Search.swift
//  Data
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import CoreData
import Domain
import RxSwift

extension CoreDataManager {
  func getSearchHistories(limit: Int) -> Observable<[History]> {
    let subject = ReplaySubject<[History]>.createUnbounded()
    let request = NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    request.fetchLimit = limit
    request.sortDescriptors = [NSSortDescriptor(key: "savedAt", ascending: false)]

    do {
      let histories = try context.fetch(request).compactMap { $0.toDomain() }
      subject.onNext(histories)
    } catch {
      print(error.localizedDescription)
      subject.onError(error)
    }

    return subject
  }

  func addSearchHistory(song: Song) -> Bool {
    if let existingHistory = getExistingHistory(song) {
      existingHistory.savedAt = Int64(Date().timeIntervalSince1970)
    } else if let existingSong = getExistingSong(song) {
      let history = HistoryEntity(context: context)
      history.song = existingSong
      history.savedAt = Int64(Date().timeIntervalSince1970)
    } else {
      let history = HistoryEntity(context: context)
      history.savedAt = Int64(Date().timeIntervalSince1970)
      history.song = song.toCoreDataEntity()
    }

    save()
    return true
  }

  func getExistingHistory(_ song: Song) -> HistoryEntity? {
    let request = NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    request.predicate = NSPredicate(format: "song.id == %lld", song.id)
    var histories = [HistoryEntity]()

    do {
      histories = try context.fetch(request)
    } catch {
      print(error.localizedDescription)
    }

    return histories.first
  }

  func getExistingSong(_ song: Song) -> SongEntity? {
    let request = NSFetchRequest<SongEntity>(entityName: "SongEntity")
    request.predicate = NSPredicate(format: "id == %lld", song.id)
    var songs = [SongEntity]()

    do {
      songs = try context.fetch(request)
    } catch {
      print(error.localizedDescription)
    }

    return songs.first
  }
}

