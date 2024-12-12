//
//  AddPlaylistSongView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import SwiftUI

struct AddPlaylistSongView: View {
  let playlistID: String
  
  @EnvironmentObject var router: LibraryRouter
  @ObservedObject var playlistVM: PlaylistViewModel
  @State private var searchText = ""
  
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
                  addToPlaylistAction: {
                    playlistVM.addToPlaylist(song: song, playlistID: playlistID)
                  },
                  removeFromPlaylistAction: {

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
    AddPlaylistSongView(playlistID: "", playlistVM: .init())
  }
}
