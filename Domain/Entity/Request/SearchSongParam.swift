//
//  SearchSongParam.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

public struct SearchSongParam: Encodable {
  public let term: String
  public let media = "music"

  public init(term: String) {
    self.term = term
  }
}
