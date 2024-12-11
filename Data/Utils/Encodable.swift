//
//  Encodable.swift
//  Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import Foundation

extension Encodable {
  var parameters: [String: Any] {
    guard let data = try? JSONEncoder().encode(self),
          let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
      return [:]
    }
    return dict
  }

  var jsonString: String {
    let jsonData = try? JSONEncoder().encode(self)
    let jsonString = String(data: jsonData ?? Data(), encoding: .utf8)!
    return jsonString
  }
}
