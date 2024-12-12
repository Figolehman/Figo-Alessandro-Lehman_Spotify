//
//  SearchRepository.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import RxSwift

public struct DefaultSearchRepository: SearchRepository {
  private let remoteDataSource: SearchRemoteDataSource
  private let localDataSource: SearchLocalDataSource

  public init(remoteDataSource: SearchRemoteDataSource, localDataSource: SearchLocalDataSource) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }

  public func getSearchSong(param: SearchSongParam) -> Observable<SearchResult> {
    remoteDataSource.getSearchSong(param: param)
  }

  public func getSearchHistories(limit: Int) -> Observable<[History]> {
    localDataSource.getSearchHistories(limit: limit)
  }

  public func addSearchHistory(song: Song) -> Bool {
    localDataSource.addSearchHistory(song: song)
  }
}
