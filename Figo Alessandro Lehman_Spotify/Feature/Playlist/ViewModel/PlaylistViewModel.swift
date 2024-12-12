//
//  PlaylistViewModel.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 12/12/24.
//

import Combine
import Data
import Domain
import RxSwift

class PlaylistViewModel: ObservableObject {
  @Published var searchResult: DataState<SearchResult> = .initiate
  @Published var addSongToPlaylistStatus: DataState<Bool> = .initiate
  @Published var removeSongFromPlaylistStatus: DataState<Bool> = .initiate
  @Published var playlist: DataState<Playlist?> = .initiate

  @Published var searchHistories: DataState<[History]> = .initiate
  @Published var addSearchHistoryStatus: DataState<Bool> = .initiate
  var searchText = PublishSubject<String>()

  let searchUseCase = SearchUseCase(
    repository:
      DefaultSearchRepository(
        remoteDataSource: DefaultSearchRemoteDataSource(),
        localDataSource: DefaultSearchlocalDataSource()
      )
  )
  let playlistUseCase = PlaylistUseCase(
    repository:
      DefaultPlaylistRepository(
        localDataSource: DefaultPlaylistlocalDataSource()
      )
  )
  let disposeBag = DisposeBag()
  private var cancellable: AnyCancellable?

  func getSearchSong(param: SearchSongParam) {
    cancellable?.cancel()
    cancellable = Just(param.term)
      .delay(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .sink { [weak self] debouncedQuery in
        guard let self else { return }
        self.searchResult = .loading
        self.searchUseCase.getSearchSong(param: param)
          .observe(on: MainScheduler.instance)
          .subscribe(
            onNext: { [weak self] result in
              self?.searchResult = .success(data: result)
            },
            onError: { [weak self] error in
              self?.searchResult = .failed(error: error)
            }
          )
          .disposed(by: self.disposeBag)
      }
  }

  func addToPlaylist(song: Song, playlistID: String) {
    addSongToPlaylistStatus = .loading
    addSongToPlaylistStatus = .success(data: playlistUseCase.addSongToPlaylist(song: song, playlistID: playlistID))
  }

  func removefromPlaylist(song: Song, playlistID: String) {
    removeSongFromPlaylistStatus = .loading
    removeSongFromPlaylistStatus = .success(data: playlistUseCase.removeSongFromPlaylist(song: song, playlistID: playlistID))
  }

  func getPlaylist(id: String) {
    playlist = .loading
    playlistUseCase.getPlaylist(id: id)
      .observe(on: MainScheduler.instance)
      .subscribe(
        onNext: { [weak self] result in
          self?.playlist = .success(data: result)
        },
        onError: { [weak self] error in
          self?.playlist = .failed(error: error)
        }
      )
      .disposed(by: disposeBag)
  }

  func getSearchHistories(limit: Int) {
    searchHistories = .loading
    searchUseCase.getSearchHistories(limit: limit)
      .observe(on: MainScheduler.instance)
      .subscribe(
        onNext: { [weak self] histories in
          self?.searchHistories = .success(data: histories)
        },
        onError: { [weak self] error in
          self?.searchHistories = .failed(error: error)
        }
      )
      .disposed(by: disposeBag)
  }

  func addSearchHistory(song: Song) {
    addSearchHistoryStatus = .loading
    addSearchHistoryStatus = .success(data: searchUseCase.addSearchHistory(song: song))
  }
}
