//
//  PlaylistListView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import SwiftUI
import Domain

struct PlaylistListView: View {
  let playlist: Playlist

  var body: some View {
    HStack(spacing: 14) {
      playlistImage()

      VStack(alignment: .leading, spacing: 6) {
        Text(playlist.name)
          .font(.avenirDemi, fontSize: 15, lineHeight: 20.49)
          .foregroundColor(.primaryText)

        HStack(spacing: 0) {
          Text(AppString.lblPlaylist)
            .font(.avenirMedium, fontSize: 13, lineHeight: 17.76)
            .padding(.horizontal, 4)

          Circle()
            .frame(width: 3, height: 3)

          Text(String(format: AppString.lblSongCount, "\(playlist.songs.count)"))
            .font(.avenirMedium, fontSize: 13, lineHeight: 17.76)
            .padding(.horizontal, 4)
        }
        .foregroundColor(.quinaryText)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }

  @ViewBuilder
  func playlistImage() -> some View {
    let playlistSongCount = playlist.songs.count
    if playlistSongCount < 4 {
      CustomWebImage(
        urlImage: playlist.songs.first?.imageURL ?? "",
        width: 66,
        height: 66,
        placeholder: .song
      )
    } else {
      LazyVGrid(columns: [GridItem(.fixed(33), spacing: 0), GridItem(.fixed(33), spacing: 0)], spacing: 0, content: {
        ForEach(Array(playlist.songs.prefix(4).enumerated()), id: \.offset) { _, song in
          CustomWebImage(
            urlImage: song.imageURL,
            width: 33,
            height: 33,
            placeholder: .song
          )
        }
      })
      .frame(width: 66, height: 66)
    }
  }
}

#Preview {
  PlaylistListView(playlist: .init(id: UUID().uuidString, name: "Tes", songs: []))
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    .background(Color.black)
}
