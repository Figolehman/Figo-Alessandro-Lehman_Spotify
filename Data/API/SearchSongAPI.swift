//
//  SearchSongAPI.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Domain
import Moya

enum SearchAPI {
  case getSearchSong(param: SearchSongParam)
}

extension SearchAPI: TargetType {
  var path: String {
    switch self {
    case .getSearchSong:
      return "search"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getSearchSong:
      return .get
    }
  }

  var task: Task {
    switch self {
    case .getSearchSong(let param):
      return .requestParameters(parameters: param.parameters, encoding: URLEncoding.queryString)
    }
  }

  // MARK: - Use variables in API instead
  var headers: [String : String]? { nil }
  var baseURL: URL { URL(string: "")! }
  var sampleData: Foundation.Data { Data() }
}
