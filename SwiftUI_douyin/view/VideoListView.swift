//
//  VideoList.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct VideoListView: View {
    var videoData:[[DVideo]]
    let maxWidth = UIScreen.main.bounds.width
    var body: some View {
        VStack(alignment:.leading,spacing:1){
            ForEach(videoData,id:\.self[0].aweme_id){videoList in
                HStack(spacing:1){
                    ForEach(videoList,id:\.self.aweme_id){
                        VideoItemView(videoData: $0)
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
            VideoListView(videoData: TestUserList[0].sort_video_list)
        }
        //.frame(height:350)
    }
}
