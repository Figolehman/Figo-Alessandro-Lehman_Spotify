//
//  SongHistoryView.swift
//  Figo Alessandro Lehman_Spotify
//
//  Created by Figo Alessandro Lehman on 12/12/24.
//

import Domain
import SwiftUI

struct SongHistoryView: View {
  let song: Song
  var body: some View {
    HStack(spacing: 13) {
      CustomWebImage(
        urlImage: song.imageURL,
        width: 50,
        height: 50,
        placeholder: .song
      )
      .clipShape(Circle())

      VStack(alignment: .leading, spacing: 3) {
        Text(song.name)
          .font(.avenirMedium, fontSize: 15, lineHeight: 20.49)
          .foregroundColor(.primaryText)

        HStack(spacing: 4) {
          Text(AppString.lblSong)
            .font(.avenirMedium, fontSize: 13, lineHeight: 17.76)

          Circle()
            .frame(width: 3, height: 3)

          Text(song.artistName)
            .font(.avenirMedium, fontSize: 13, lineHeight: 17.76)
        }
        .foregroundColor(.quinaryText)
        .padding(.leading, 2)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

#Preview {
  SongHistoryView(song: Song(id: 213, name: "ME", artistName: "FIGO", imageURL: ""))
    .background(
      Color.black
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .ignoresSafeArea()
    )
}
