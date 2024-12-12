//
//  SongLocalDataSource.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import RxSwift

public protocol SearchLocalDataSource {
  func getSearchHistories(limit: Int) -> Observable<[History]>
  func addSearchHistory(song: Song) -> Bool
}

public struct DefaultSearchlocalDataSource: SearchLocalDataSource {
  public init() {}

  public func getSearchHistories(limit: Int) -> Observable<[History]> {
    CoreDataManager.shared.getSearchHistories(limit: limit)
  }

  public func addSearchHistory(song: Song) -> Bool{
    CoreDataManager.shared.addSearchHistory(song: song)
  }
}
