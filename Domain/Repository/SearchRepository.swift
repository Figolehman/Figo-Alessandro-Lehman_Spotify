//
//  SearchRepository.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import RxSwift

public protocol SearchRepository {
  func getSearchSong(param: SearchSongParam) -> Observable<SearchResult>

  func getSearchHistories(limit: Int) -> Observable<[History]>
  func addSearchHistory(song: Song) -> Bool
}
