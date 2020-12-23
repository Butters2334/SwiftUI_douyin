//
//  VideoList.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct VideoItem: View {
    var videoData:DVideo
    var body: some View {
        loadImage(videoData.cover)
            .resizable(resizingMode: .stretch)
            .scaledToFill()
            .frame(height: 180)
            .clipped()
            .overlay(
                HStack(spacing:5){
                    Image(systemName: "suit.heart")
                    Text(videoData.statistics.play_count.countText)
                    .bold()
                }
                .shadow(color: .black, radius: 4, x: 4, y: 4)
                .font(.system(size: 12))
                .padding(EdgeInsets(top: 0, leading: 7, bottom: 7, trailing: 0))
                .foregroundColor(.white),
                alignment: .bottomLeading)
    }
}

struct VideoList: View {
    var videoData:[[DVideo]]
    let maxWidth = UIScreen.main.bounds.width
    var body: some View {
        VStack(alignment:.leading,spacing:1){
            ForEach(videoData,id:\.self[0].aweme_id){videoList in
                HStack(spacing:1){
                    ForEach(videoList,id:\.self.aweme_id){
                        VideoItem(videoData: $0)
                    }
                }
                .frame(width:self.maxWidth/3*CGFloat(videoList.count))
            }
        }.background(Color.black)
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            VideoList(videoData: TestUserList[0].sort_video_list)
        }
    }
}
