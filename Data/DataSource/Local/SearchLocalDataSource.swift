//
//  SongLocalDataSource.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain

public protocol SearchLocalDataSource {
  func addSearchHistory(song: Song)
}

public struct DefaultSearchlocalDataSource: SearchLocalDataSource {
  public init() {}

  public func addSearchHistory(song: Song) {
    
  }
}
