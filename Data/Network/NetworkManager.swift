//
//  NetworkManager.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import Foundation
import Moya
import RxSwift

protocol Networkable {
  func fetchSongs(param: SearchSongParam, completion: @escaping (Result<SearchResult, Error>) -> ())
}

class NetworkManager: Networkable {
  private let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])

  func fetchSongs(param: SearchSongParam, completion: @escaping (Result<SearchResult, Error>) -> ()) {
    request(target: .searchAPI(api: .getSearchSong(param: param)), completion: completion)
  }
}

private extension NetworkManager {
  private func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
    provider.request(target) { result in
      switch result {
      case let .success(response):
        do {
          let results = try JSONDecoder().decode(T.self, from: response.data)
          completion(.success(results))
        } catch let error {
          completion(.failure(error))
        }
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
}

class NetworkService {
  private let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
  static let shared = NetworkService()

  private init() {}

  func connect<T: Decodable>(api: API, mappableType: T.Type) -> Observable<T> {
    let subject = ReplaySubject<T>.createUnbounded()

    provider.request(api) { (result) in
      switch result {
      case .success(let value):
        do {
          let results = try JSONDecoder().decode(T.self, from: value.data)

          subject.onNext(results)
          subject.onCompleted()
        } catch {
          subject.onError(ApiError.failedMappingError)
        }
      case .failure:
        subject.onError(ApiError.connectionError)
      }
    }

    return subject
  }
}
