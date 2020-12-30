//
//  LikeList.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/29.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

private struct NoLikeView :View{
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(height:340)
            .overlay(
                VStack(spacing:15){
                    Text("暂无内容")
                        .font(.system(size: 18))
                    Text("该用户还没有喜欢过内容")
                        .font(.system(size: 15))
                        .opacity(0.7)
                }
                .foregroundColor(.white)
                .padding(.top,30)
                ,alignment: .top
            )
    }
}

struct LikeListView: View {
    var videoData:[[DVideo]]
    let maxWidth = UIScreen.main.bounds.width
    var listView: some View {
        VStack(alignment:.leading,spacing:1){
            ForEach(self.videoData,id:\.self[0].aweme_id){videoList in
                HStack(spacing:1){
                    ForEach(videoList,id:\.self.aweme_id){
                        VideoItemView(videoData: $0)
                    }
                }
                .frame(width:self.maxWidth/3*CGFloat(videoList.count))
            }
        }.background(Color.black)
    }
    var body: some View {
        Group{
            if videoData.count == 0 {
                NoLikeView()
            }else{
                listView
            }
        }
    }
}

struct LikeList_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            LikeListView(videoData: TestUserList[0].favoriting_video_list)
        }
        .background(colorRGB(0x151823))
        .frame(height:340)
    }
}
