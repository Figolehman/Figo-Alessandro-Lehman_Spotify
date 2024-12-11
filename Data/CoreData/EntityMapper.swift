//
//  EntityMapper.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain

public extension Song {
  @discardableResult
  func toCoreDataEntity() -> SongEntity {
    let entity = SongEntity(context: CoreDataManager.shared.context)
    entity.id = id
    entity.name = name
    entity.artistName = artistName
    entity.imageURL = imageURL
    return entity
  }
}

public extension SongEntity {
  func toDomain() -> Song {
    return Song(
      id: id,
      name: name ?? "",
      artistName: artistName ?? "",
      imageURL: imageURL ?? ""
    )
  }
}

public extension PlaylistEntity {
  func toDomain() -> Playlist {
    return Playlist(
      id: id ?? "",
      name: name ?? "",
      songs: (songs?.allObjects as? [SongEntity] ?? []).compactMap { $0.toDomain() }
    )
  }
}

public extension Playlist {
  @discardableResult
  func toCoreDataEntity() -> PlaylistEntity {
    let entity = PlaylistEntity(context: CoreDataManager.shared.context)
    entity.id = id
    entity.name = name
    entity.songs?.adding(songs)
    return entity
  }
}
