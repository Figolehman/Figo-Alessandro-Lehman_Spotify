//
//  API.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Foundation
import Moya

enum API {
  case searchAPI(api: SearchAPI)
}

extension API: TargetType {
  var baseURL: URL {
    URL(string: "https://itunes.apple.com")!
  }
  
  var path: String {
    switch self {
    case .searchAPI(let api):
      return api.path
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .searchAPI(let api):
      return api.method
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .searchAPI(let api):
      return api.task
    }
  }
  
  var headers: [String : String]? {
    ["Content-type": "application/json"]
  }
  
  var sampleData: Data {
    Data()
  }
}
