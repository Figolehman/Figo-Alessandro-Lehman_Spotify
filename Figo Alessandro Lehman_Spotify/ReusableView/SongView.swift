//
//  SongView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 12/12/24.
//

import Domain
import SwiftUI

struct SongView: View {
  let song: Song
  let isAddableToPlaylist: Bool
  var isAddedToPlaylist = false
  var addToPlaylistAction: (() -> Void)? = nil
  var removeFromPlaylistAction: (() -> Void)? = nil

  var body: some View {
    HStack(spacing: 13) {
      CustomWebImage(
        urlImage: song.imageURL,
        width: 52,
        height: 52,
        placeholder: .song
      )

      VStack(alignment: .leading, spacing: 8.5) {
        Text(song.name)
          .font(.circularMedium, fontSize: 14, lineHeight: 11.2)
          .foregroundColor(.primaryText)
          .lineLimit(1)

        Text(song.artistName)
          .font(.circularBook, fontSize: 11, lineHeight: 8.8)
          .foregroundColor(.secondaryText)
          .lineLimit(1)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      if isAddedToPlaylist {
        Image(.icThreeDots)
          .resizable()
          .frame(width: 3, height: 18)
      } else {
        Button {
          isAddedToPlaylist ? removeFromPlaylistAction?() : addToPlaylistAction?()
        } label: {
          if isAddedToPlaylist {
            Circle()
              .stroke(.primaryText, lineWidth: 1)
              .frame(width: 14, height: 14)
              .overlay (
                Color.primaryText
                  .frame(height: 1)
                  .padding(.horizontal, 2)
              )
          } else {
            Image(.icPlus)
              .resizable()
              .renderingMode(.template)
              .foregroundColor(.primaryText)
              .frame(width: 14, height: 14)
              .background(
                Circle()
                  .stroke(.primaryText, lineWidth: 1)
              )
          }
        }
      }
    }
  }
}

#Preview {
  SongView(song: Song(id: 12312, name: "ME~", artistName: "Figo", imageURL: ""), isAddableToPlaylist: true, isAddedToPlaylist: true, addToPlaylistAction: {})
    .background(Color.black.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight).ignoresSafeArea())
}
