//
//  PlaylistDetailView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import SwiftUI

struct PlaylistDetailView: View {
  @EnvironmentObject var router: LibraryRouter
  let playlist: Playlist

  var body: some View {
    VStack(spacing: 75) {
      VStack(alignment: .leading, spacing: 9) {
        Text(playlist.name)
          .foregroundColor(.primaryText)

        Text(String(format: AppString.lblSongCount, "\(playlist.songs.count)"))
          .foregroundColor(.secondaryText)

        Spacer()
      }
    }
    .padding(.horizontal, 16)
    .padding(.top, 26)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      Image(.imgGradientBackground)
        .resizable()
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .ignoresSafeArea()
    )
    .navigationBarBackButtonHidden()
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          router.navigateBack()
        } label: {
          Image(.icLeftArrow)
            .resizable()
            .frame(width: 20, height: 14)
        }
      }
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          router.navigate(to: .addPlaylistSong(playlistID: playlist.id))
        } label: {
          Image(.icPlus)
            .resizable()
            .frame(width: 26, height: 26)
        }
      }
    }
  }
}

#Preview {
  NavigationView {
    PlaylistDetailView(playlist: .init(name: "asd", songs: []))
      .environmentObject(LibraryRouter())
  }
}
