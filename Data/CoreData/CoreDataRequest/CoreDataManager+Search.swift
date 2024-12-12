//
//  CoreDataManager+Search.swift
//  Data
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import CoreData
import Domain

protocol CoreDataSearch {
  func getSearchHistory() -> [HistoryEntity]
  func addSearchHistory(song: Song)
}

extension CoreDataManager: CoreDataSearch {
  func getSearchHistory() -> [HistoryEntity] {
    let request = NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")

    do {
      return try context.fetch(request)
    } catch {
      print(error.localizedDescription)
    }

    return []
  }

  func addSearchHistory(song: Song) {
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
  }

  func getExistingHistory(_ song: Song) -> HistoryEntity? {
    let request = NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    request.predicate = NSPredicate(format: "songs. == %lld", song.id)
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

