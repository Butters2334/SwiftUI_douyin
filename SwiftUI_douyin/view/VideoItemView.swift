//
//  VideoItemView.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct VideoItemView: View {
    var videoData:DVideo
    var body: some View {
        loadImage(videoData.cover)
            .resizable(resizingMode: .stretch)
            .scaledToFill()
            .frame(height: videoData.coverSize.height)
            .clipped()
            .overlay(playCount,
            alignment: .bottomLeading)
    }
    var playCount: some View {
        HStack(spacing:5){
            Image(systemName: "suit.heart")
            Text(videoData.statistics.play_count.countText)
            .bold()
        }
        .shadow(color: .black, radius: 4, x: 4, y: 4)
        .font(.system(size: 12))
        .padding(EdgeInsets(top: 0, leading: 7, bottom: 7, trailing: 0))
        .foregroundColor(.white)
    }
}

struct VideoItemView_Previews: PreviewProvider {
    static var previews: some View {
        VideoItemView(videoData: TestUserList[0].video_list[0])
    }
}
