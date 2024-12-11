//
//  ContentView.swift
//  Spotify Assigmnent
//
//  Created by Figo Alessandro Lehman on 06/12/24.
//

import SwiftUI

struct MainTabBarView: View {
  private let currentTab: SpotifyTabItem = .library

  var body: some View {
    VStack(spacing: 0) {
      LibraryView()
        .frame(maxHeight: .infinity)

      HStack {
        ForEach(Array(SpotifyTabItem.allCases.enumerated()), id: \.offset) { index, item in
          VStack(spacing: 7) {
            Image(item.icon)
              .resizable()
              .frame(width: 20, height: 20)
          
            let isSelected = currentTab == item
            Text(item.label)
              .foregroundColor(isSelected ? .primaryText : .tertiaryText)
              .font(.avenirRegular, fontSize: 11, lineHeight: 15)
          }
          .frame(width: 60)

          if index < SpotifyTabItem.allCases.count - 1 {
            Spacer()
          }
        }
      }
      .padding(.top, 8)
      .padding(.horizontal, 24)
      .background(Color.primaryBackground)
    }
  }
}

#Preview {
  MainTabBarView()
}
