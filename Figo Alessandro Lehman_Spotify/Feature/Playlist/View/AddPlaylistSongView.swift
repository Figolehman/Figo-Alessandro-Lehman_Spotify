//
//  AddPlaylistSongView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import SwiftUI

struct AddPlaylistSongView: View {
  @State private var playlist: Playlist

  @EnvironmentObject var router: LibraryRouter
  @ObservedObject var playlistVM: PlaylistViewModel
  @State private var searchText = ""

  init(playlist: Playlist, playlistVM: PlaylistViewModel) {
    self._playlist = State(initialValue: playlist)
    self.playlistVM = playlistVM
  }

  var body: some View {
    VStack(spacing: 33) {
      navigationBar()
        .padding(.top, 14)

      ScrollView {
        VStack(spacing: 20) {
          if searchText.count == 0 {
            Text(AppString.lblSearchHistory)
              .font(.avenirDemi, fontSize: 17, lineHeight: 23.22)
              .foregroundColor(.primaryText)
              .frame(maxWidth: .infinity, alignment: .leading)

            if case let .success(histories) = playlistVM.searchHistories {
              ForEach(Array(histories.enumerated()), id: \.offset) { _, history in
                SongHistoryView(song: history.song)
              }
            }
          } else {
            Text(AppString.lblSearchResult)
              .font(.avenirDemi, fontSize: 17, lineHeight: 23.22)
              .foregroundColor(.primaryText)
              .frame(maxWidth: .infinity, alignment: .leading)

            if case let .success(result) = playlistVM.searchResult {
              ForEach(result.songs, id: \.id) { song in
                SongView(
                  song: song,
                  isAddableToPlaylist: true,
                  isAddedToPlaylist: playlist.songs.contains(where: { playlistSong in
                    song.id == playlistSong.id
                  }),
                  addToPlaylistAction: {
                    playlistVM.addToPlaylist(
                      song: song,
                      playlistID: playlist.id
                    )
                  },
                  removeFromPlaylistAction: {
                    playlistVM.removefromPlaylist(
                      song: song,
                      playlistID: playlist.id
                    )
                  }
                )
                .onTapGesture {
                  playlistVM.addSearchHistory(song: song)
                }
              }
            } else if .loading == playlistVM.searchResult {
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .primaryText))
            }
          }
        }
        .padding(.horizontal, 28)
      }

      Spacer()
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.primaryBackground
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .ignoresSafeArea()
    )
    .onAppear {
      playlistVM.getSearchHistories(limit: 10)
    }
    .onChange(of: searchText) { _, newValue in
      if newValue.isEmpty {
        playlistVM.getSearchHistories(limit: 10)
      } else {
        playlistVM.getSearchSong(
          param: SearchSongParam(term: newValue)
        )
      }
    }
    .observeData(
      playlistVM.$addSongToPlaylistStatus,
      onNext: { _ in
        playlistVM.getPlaylist(id: playlist.id)
      }
    )
    .observeData(
      playlistVM.$removeSongFromPlaylistStatus,
      onNext: { _ in
        playlistVM.getPlaylist(id: playlist.id)
      }
    )
    .observeData(
      playlistVM.$playlist,
      onNext: { playlist in
        guard let playlist else { return }
        self.playlist = playlist
      }
    )
    .observeData(
      playlistVM.$addSongToPlaylistStatus,
      onNext: { _ in
        playlistVM.getSearchHistories(limit: 10)
      }
    )
  }
}

// MARK: - View Components
private extension AddPlaylistSongView {
  @ViewBuilder
  func navigationBar() -> some View {
    HStack(spacing: 19){
      HStack(spacing: 10) {
        Image(.icSearch)
          .resizable()
          .renderingMode(.template)
          .frame(width: 12, height: 12)

        TextField(
          "",
          text: $searchText,
          prompt:
            Text(AppString.lblSearch)
            .font(.custom(type: .avenirMedium, size: 15))
            .foregroundColor(.primaryText)
        )
      }
      .padding(EdgeInsets(top: 9, leading: 10.21, bottom: 7, trailing: 0))
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Color.searchBarBackground)
      .foregroundColor(.primaryText)
      .cornerRadius(10)

      Button {
        router.navigateBack()
      } label: {
        Text(AppString.lblCancel)
          .foregroundColor(.primaryText)
          .padding(.horizontal, 6)
      }
    }
    .padding(.leading, 17)
  }
}

#Preview {
  NavigationView {
    AddPlaylistSongView(playlist: .init(name: "ASDASd", songs: []), playlistVM: .init())
  }
}
