//
//  SongUseCase.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import RxSwift

public struct SongUseCase {
  private let repository: SongRepository

  public init(repository: SongRepository) {
    self.repository = repository
  }

  public func getSearchSong(param: SearchSongParam) -> Observable<SearchResult> {
    repository.getSearchSong(param: param)
  }
}
