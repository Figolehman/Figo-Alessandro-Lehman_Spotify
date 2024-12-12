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
    ScrollView {
      VStack(spacing: 33) {
        navigationBar()
          .padding(.top, 14)
        
        VStack(spacing: 20) {
          if searchText.count == 0 {
            Text("Recent Searches")
              .font(.avenirDemi, fontSize: 17, lineHeight: 23.22)
              .foregroundColor(.primaryText)
              .frame(maxWidth: .infinity, alignment: .leading)
          } else {
            Text("Search Result")
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
              }
            }
          }
        }
        .padding(.horizontal, 28)

        Spacer()
      }
    }
    .navigationBarBackButtonHidden()
    .background(
      Color.primaryBackground
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .ignoresSafeArea()
    )
    .onAppear {
      
    }
    .onChange(of: searchText) { _, newValue in
      playlistVM.getSearchSong(
        param: SearchSongParam(term: newValue)
      )
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
            Text("Search")
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
        Text("Cancel")
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
