//
//  UserView.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

//用户主页面
struct UserView: View {
    let user:DUser
    let bgColor = colorRGB(0x151823)
    @State var leftPercent:CGFloat //0左,1右
    @State private var scrollOffset: CGFloat = 0    //列表滑动监控
    //视图合并
    var body: some View {
        ZStack(alignment: .top) {
            bgView
            scrollView
            navigation
        }
        .background(bgColor)
        //上下适配
        .edgesIgnoringSafeArea(.all)
    }
    //背景图
    var bgView : some View{
        ZStack{
            loadImage(self.user.user_bg)
                .resizable()
                .scaledToFill()
                .frame(height:140)
                .padding(self.padding)
        }
    }
    //视频列表内容
    func getContent(_ geometry:GeometryProxy)->some View {
        let pageWidth = geometry.size.width;
        let pageSize = CGSize(width: pageWidth*2,
                              height: self.hsHeight);
        let pageContent = {
            HStack(spacing:0){
                VideoListView(videoData: self.user.sort_video_list)
                    .frame(width:geometry.size.width)
                LikeListView(videoData: self.user.favoriting_video_list)
                    .frame(width:geometry.size.width,
                           height:self.hsHeight)
            }
            .background(self.bgColor)
        }
        return VStack(alignment:.center,spacing:0){
            //占用100像素给后面的背景图
            Color.clear.frame(height:100)
            //用户信息区域
            UserContentView(user: self.user, bgColor: self.bgColor)
            //列表左右可切换
            VideoSelectView(videoCount: self.user.aweme_count,
                        likeCount: self.user.favoriting_count,
                        leftPercent: self.$leftPercent)
                .background(self.bgColor)
            //视频列表
            PageScrollView(pageWidth: pageWidth,
                                  contentSize: pageSize,
                                  leftPercent:self.$leftPercent,
                                  content: pageContent)
                .frame(height:self.hsHeight)
            //底部适配X的屏幕下方
            self.bgColor
                .frame(height:geometry.safeAreaInsets.bottom)
        }
    }
    //视频列表
    var scrollView: some View {
        GeometryReader{ geometry in
            ScrollViewOffset(onOffsetChange: {
                self.scrollOffset = $0
            }, content: {
                self.getContent(geometry)
            })
        }
    }
    //导航栏
    var navigation: some View {
        UserNavigationView(bgColor: bgColor,
                           nickname: user.nickname,
                           scrollOffset: $scrollOffset,
                           backTap: {print("backTap")},
                           moreTap: {print("moreTap")})
    }
    //视频列表高度依赖左右切换
    var hsHeight:CGFloat {
        self.leftPercent==0
            ?
            self.user.video_view_height
            :
            self.user.like_view_height
    }
    //背景图片滑动效果
    var padding:EdgeInsets {
        let gap = CGFloat(60.0)
        if scrollOffset <= gap {
            return EdgeInsets()
        }
        let offset = max(-scrollOffset + gap,-55)
        return EdgeInsets(top: offset * -1.2,
                          leading: offset,
                          bottom: offset,
                          trailing: offset)
    }
}

//所有预览依赖PreviewProvider协议
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user:TestUserList[0],leftPercent: 0)
    }
}
