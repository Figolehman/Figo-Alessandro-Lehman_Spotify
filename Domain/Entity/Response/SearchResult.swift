//
//  SearchResult.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Foundation

public struct SearchResult: Codable {
  public var resultCount: Int
  public var songs: [Song]

  enum CodingKeys: String, CodingKey {
    case resultCount = "resultCount"
    case songs = "results"
  }
}
