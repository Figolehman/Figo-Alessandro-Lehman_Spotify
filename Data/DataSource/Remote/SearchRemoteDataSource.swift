//
//  SongRemoteDataSource.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import RxSwift

public protocol SearchRemoteDataSource {
  func getSearchSong(param: SearchSongParam) -> Observable<SearchResult>
}

public struct DefaultSearchRemoteDataSource: SearchRemoteDataSource {
  public init() {}

  public func getSearchSong(param: SearchSongParam) -> Observable<SearchResult> {
    return NetworkService.shared.connect(api: .searchAPI(api: .getSearchSong(param: param)), mappableType: SearchResult.self)
  }
}
