//
//  SongRepository.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import RxSwift

public protocol SongRepository {
  func getSearchSong(param: SearchSongParam) -> Observable<SearchResult>
}
