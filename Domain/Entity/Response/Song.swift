//
//  Song.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Foundation

public struct Song: Codable {
  public var id: Int64
  public var name: String
  public var artistName: String
  public var imageURL: String

  public init(id: Int64, name: String, artistName: String, imageURL: String) {
    self.id = id
    self.name = name
    self.artistName = artistName
    self.imageURL = imageURL
  }

  enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case name = "trackName"
    case artistName = "artistName"
    case imageURL = "artworkUrl100"
  }
}
