//
//  Figo_Alessandro_Lehman_SpotifyApp.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import netfox
import SwiftUI

@main
struct Figo_Alessandro_Lehman_SpotifyApp: App {
  init() {
    NFX.sharedInstance().start()
  }

  var body: some Scene {
    WindowGroup {
      MainTabBarView()
    }
  }
}
