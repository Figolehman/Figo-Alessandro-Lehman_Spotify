//
//  SearchUseCase.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import RxSwift

public struct SearchUseCase {
  private let repository: SearchRepository

  public init(repository: SearchRepository) {
    self.repository = repository
  }

  public func getSearchSong(param: SearchSongParam) -> Observable<SearchResult> {
    repository.getSearchSong(param: param)
  }

  public func getSearchHistories(limit: Int) -> Observable<[History]> {
    repository.getSearchHistories(limit: limit)
  }

  public func addSearchHistory(song: Song) -> Bool {
    repository.addSearchHistory(song: song)
  }
}
