//
//  History.swift
//  Domain
//
//  Created by Figo Alessandro Lehman on 12/12/24.
//

import Foundation

public struct History {
  public var savedAt: Int64
  public var song: Song

  public init(song: Song) {
    self.savedAt = Int64(Date().timeIntervalSince1970)
    self.song = song
  }
}
