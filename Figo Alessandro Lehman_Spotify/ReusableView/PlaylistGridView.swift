//
//  PlaylistGridView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import SwiftUI

struct PlaylistGridView: View {
  let playlist: Playlist

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      playlistImage()

      VStack(alignment: .leading, spacing: 2) {
        Text(playlist.name)
          .foregroundColor(.primaryText)
          .font(.circularBold, fontSize: 11, lineHeight: 14)

        HStack(spacing: 4) {
          Text(AppString.lblPlaylist)
            .font(.circularBold, fontSize: 11, lineHeight: 14)

          Circle()
            .frame(width: 3, height: 3)

          Text(String(format: AppString.lblSongCount, "\(playlist.songs.count)"))
            .font(.circularBook, fontSize: 11, lineHeight: 14)
        }
        .foregroundColor(.secondaryText)
        .padding(.leading, 2)
      }
    }
  }

  @ViewBuilder
  func playlistImage() -> some View {
    let playlistSongCount = playlist.songs.count
    // MARK: - width is calculated based on screen width minus view padding and spacing between content
    let contentWidth: CGFloat = (UIScreen.screenWidth - 46) / 2
    if playlistSongCount < 4 {
      CustomWebImage(
        urlImage: playlist.songs.first?.imageURL ?? "",
        width: contentWidth,
        height: contentWidth,
        placeholder: .song
      )
    } else {
      LazyVGrid(columns: [GridItem(.fixed(contentWidth/2), spacing: 0), GridItem(.fixed(contentWidth/2), spacing: 0)], spacing: 0, content: {
        ForEach(Array(playlist.songs.prefix(4).enumerated()), id: \.offset) { _, song in
          CustomWebImage(
            urlImage: song.imageURL,
            width: contentWidth/2,
            height: contentWidth/2,
            placeholder: .song
          )
        }
      })
      .frame(width: contentWidth, height: contentWidth)
    }
  }
}

#Preview {
  PlaylistGridView(playlist: .init(id: UUID().uuidString, name: "Tes", songs: Array(repeating: .init(id: 21313, name: "ASODJAOS", artistName: "ASDAJSD", imageURL: ""), count: 4)))
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    .background(Color.black)
}
