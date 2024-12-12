//
//  DataState.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Foundation
import SwiftUI

enum DataState<T>: Equatable {
  static func == (lhs: DataState<T>, rhs: DataState<T>) -> Bool {
    return true
  }

  case initiate
  case loading
  case failed(error: Error)
  case success(data: T)

  var value: T? {
    if case .success(let data) = self {
      return data
    }
    return nil
  }
}

extension DataState {
  var isLoading: Bool {
    get {
      if case .loading = self {
        return true
      }
      return false
    }
    set {
      if newValue {
        self = .loading
      }
    }
  }
}

extension View {
  func observeData<T>(
    _ data: Published<DataState<T>>.Publisher,
    onNext: ((T) -> Void)? = nil,
    onLoading: ((Bool) -> Void)? = nil,
    onError: ((Error) -> Void)? = nil
  ) -> some View {
    self
      .onReceive(data) { state in
        switch state {
        case .success(let value):
          onLoading?(false)
          onNext?(value)
        case .loading:
          onLoading?(true)
        case .failed(let error):
          onLoading?(false)
          onError?(error)
        default:
          break
        }
      }
  }
}
