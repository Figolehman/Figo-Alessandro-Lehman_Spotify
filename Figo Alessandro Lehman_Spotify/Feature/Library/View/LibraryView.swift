//
//  LibraryView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import SwiftUI

fileprivate enum PlaylistsLayout {
  case list, grid
}

struct LibraryView: View {
  @StateObject var router = LibraryRouter()
  @StateObject var libraryVM = LibraryViewModel()
  @State private var isShowingAddSheet = false

  @State private var shouldShowAddPlaylistSheet = false
  @State private var isShowingAddPlaylistSheet = false

  @State private var shouldNavigateToPlaylist = false

  @State private var playlistInputName = AppString.lblPlaylistNamePlaceholder
  @State private var playlistToAdd: Playlist? = nil

  @State private var playlistsLayout: PlaylistsLayout = .list

  var body: some View {
    NavigationStack(path: $router.navPath) {
      VStack(spacing: 14) {
        navigationView()

        ChipView(
          label: AppString.lblPlaylist
        )
        .frame(maxWidth: .infinity, alignment: .leading)

        listView()
      }
      .padding(.top, 28)
      .padding(.horizontal, 16)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        Color.primaryBackground
      )
      .sheet(
        isPresented: $isShowingAddPlaylistSheet,
        onDismiss: {
          if let playlistToAdd,
             shouldNavigateToPlaylist {
            router.navigate(to: .playlistDetail(playlist: playlistToAdd))
            shouldNavigateToPlaylist = false
            self.playlistToAdd = nil
          }
        },
        content: {
        VStack(spacing: 98) {
          Text(AppString.lblSheetTitleAddPlaylist)
            .font(.custom(type: .circularMedium, size: 24))
            .foregroundColor(.primaryText)


          VStack(spacing: 41) {
            VStack(spacing: 8) {
              TextField("", text: $playlistInputName)
                .font(.custom(type: .circularMedium, size: 24))
                .foregroundColor(.primaryText)
                .padding(.horizontal, 4)
                .frame(maxWidth: .infinity)

              Rectangle()
                .fill(Color.textFieldUnderline)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
            }

            Button {
              let playlist = Playlist(name: playlistInputName, songs: [])
              playlistToAdd = playlist
              libraryVM.addPlaylist(playlist: playlist)
              shouldNavigateToPlaylist = true
              isShowingAddPlaylistSheet = false
            } label: {
              Text(AppString.lblConfirm)
                .font(.circularMedium, fontSize: 20, lineHeight: 16)
                .foregroundColor(.black)
                .padding(.horizontal, 32)
                .padding(.vertical, 18)
                .background(Color.primaryButton)
                .cornerRadius(26)
            }
          }
        }
        .padding(.horizontal, 38)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.sheetBackground)
        .presentationDetents([.fraction(0.999)])
      })
      .sheet(
        isPresented: $isShowingAddSheet,
        onDismiss: {
          if shouldShowAddPlaylistSheet {
            isShowingAddPlaylistSheet = true
            shouldShowAddPlaylistSheet = false
          }
        },
        content: {
          HStack(spacing: 21) {
            VStack(spacing: 2) {
              Image(.icAddPlaylist)
                .resizable()
                .frame(width: 32, height: 32)

              Text(AppString.lblPlaylist)
                .font(.montserratRegular, fontSize: 12, lineHeight: 20)
                .foregroundColor(.secondaryText)
            }

            Text(AppString.lblPlaylist + "\n")
              .font(.custom(type: .circularMedium, size: 20))
              .foregroundColor(.primaryText) +
            Text(AppString.lblAddPlaylistDescription)
              .font(.custom(type: .circularMedium, size: 13))
              .foregroundColor(.quaternaryText)

            Spacer()
          }
          .padding(.horizontal, 17)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .onTapGesture {
            isShowingAddSheet = false
            shouldShowAddPlaylistSheet = true
          }
          .background(Color.sheetBackground)
          .presentationDetents([.height(96)])
      })
      .navigationDestination(for: LibraryRouter.Destination.self) { destination in
        switch destination {
        case let .playlistDetail(playlist):
          PlaylistDetailView(
            playlist: playlist
          )
        case let .addPlaylistSong(playlist, playlistVM):
          AddPlaylistSongView(
            playlist: playlist,
            playlistVM: playlistVM
          )
        }
      }
      .onAppear {
        libraryVM.getPlaylists()
      }
    }
    .environmentObject(router)
  }
}

// MARK: - View Components
private extension LibraryView {
  @ViewBuilder
  func navigationView() -> some View {
    HStack(spacing: 4) {
      Image(.imgProfile)
        .resizable()
        .frame(width: 34, height: 34)

      Text(AppString.lblTitleLibraryView)
        .font(.avenirDemi, fontSize: 24, lineHeight: 32.78)
        .foregroundColor(.primaryText)
        .frame(height: 30)

      Spacer()

      Image(.icPlus)
        .resizable()
        .frame(width: 26, height: 26)
        .onTapGesture {
          isShowingAddSheet = true
        }
    }
    .padding(EdgeInsets(top: 8, leading: 0, bottom: 13, trailing: 0))
  }

  @ViewBuilder
  func listView() -> some View {
    VStack {
      Button {
        playlistsLayout = playlistsLayout == .grid ? .list : .grid
      } label: {
        Image(playlistsLayout == .list ? .icGrid : .icList)
          .resizable()
          .frame(width: 16, height: 16)
          .frame(maxWidth: .infinity, alignment: .trailing)
      }
      if case .success(let playlists) = libraryVM.playlists {
        switch playlistsLayout {
        case .list:
          VStack {
            ForEach(playlists, id: \.id) { playlist in
              PlaylistListView(playlist: playlist)
                .onTapGesture {
                  router.navigate(to: .playlistDetail(playlist: playlist))
                }
            }
          }
        case .grid:
          let columns = Array(repeating: GridItem(.flexible()), count: 2)
          LazyVGrid(columns: columns, spacing: 32, content: {
            ForEach(playlists, id: \.id) { playlist in
              PlaylistGridView(playlist: playlist)
                .onTapGesture {
                  router.navigate(to: .playlistDetail(playlist: playlist))
                }
            }
          })
        }
      }
      Spacer()
    }
    .padding(.vertical, 15)
  }
}

#Preview {
  LibraryView()
}
