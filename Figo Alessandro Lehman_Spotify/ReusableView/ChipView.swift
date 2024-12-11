//
//  ChipView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 11/12/24.
//

import SwiftUI

struct ChipView: View {
  let label: String
  var body: some View {
    Text(label)
      .font(.avenirMedium, fontSize: 12, lineHeight: 16.39)
      .foregroundColor(.primaryText)
      .padding(.vertical, 8)
      .padding(.horizontal, 20)
      .overlay(
        RoundedRectangle(cornerRadius: 45)
          .stroke(Color.primaryBorder)
      )
  }
}

#Preview {
  ChipView(label: "Hello, World!")
    .background(Color.primaryBackground)
}
