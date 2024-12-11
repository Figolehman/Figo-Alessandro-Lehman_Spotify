//
//  Playlist.swift
//  Domain
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Foundation

public struct Playlist {
  public var id: String
  public var name: String
  public var songs: [Song]

  public init(id: String = UUID().uuidString, name: String, songs: [Song]) {
    self.id = id
    self.name = name
    self.songs = songs
  }
}
