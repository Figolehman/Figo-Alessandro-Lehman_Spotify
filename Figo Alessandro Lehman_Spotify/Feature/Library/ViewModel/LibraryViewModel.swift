//
//  LibraryViewModel.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import Data
import SwiftUI
import RxSwift

class LibraryViewModel: ObservableObject {
  @Published var playlists: DataState<[Playlist]> = .initiate
  @Published var addPlaylistStatus: DataState<Bool> = .initiate

  let playlistUseCase = PlaylistUseCase(
    repository: DefaultPlaylistRepository(
      localDataSource: DefaultPlaylistlocalDataSource()
    )
  )
  
  let disposeBag = DisposeBag()

  func addPlaylist(playlist: Playlist) {
    addPlaylistStatus = .loading
    addPlaylistStatus = .success(data: playlistUseCase.addPlaylist(playlist: playlist))
  }

  func getPlaylists() {
    playlists = .loading
    playlistUseCase.getPlaylists()
      .observe(on: MainScheduler.instance)
      .subscribe(
        onNext: { [weak self] result in
          self?.playlists = .success(data: result)
        },
        onError: { [weak self] error in
          self?.playlists = .failed(error: error)
        }
      )
      .disposed(by: disposeBag)
  }
}
