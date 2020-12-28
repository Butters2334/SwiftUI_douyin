//
//  UserView.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI



struct UserView: View {
    let user:DUser
    let bgColor = colorRGB(0x151823)
    @State var leftPercent:CGFloat //0左,1右

    @State private var scrollOffset: CGFloat = 0
    var body: some View {
        ZStack(alignment: .top) {
            bgView
            scrollView
            statusBarView
        }
        .background(bgColor)
        //上下适配
        .edgesIgnoringSafeArea(.all)
    }
    
    var  bgView : some View{
        loadImage(self.user.user_bg)
            .resizable()
            .scaledToFill()
            .frame(height:140)
            .padding(self.padding)
    }
    
    var scrollView: some View {
        GeometryReader{ geometry in
            ScrollViewOffset(onOffsetChange: {
                self.scrollOffset = $0
            }, content: {
                VStack(alignment:.center,spacing:0){
                    //占用100像素给后面的背景图
                    Color.clear.frame(height:100)
                    
                    UserContent(user: self.user, bgColor: self.bgColor)
                    
                    VideoSelect(videoCount: self.user.aweme_count,
                                likeCount: self.user.favoriting_count,
                                leftPercent: 0)
                        .background(self.bgColor)

                    VideoList(videoData: self.user.sort_video_list)

                    //底部适配X的屏幕下方
                    self.bgColor
                        .frame(height:geometry.safeAreaInsets.bottom)
                }
            })
        }
    }
    
    var statusBarView: some View {
        GeometryReader{ geometry in
            HStack(alignment:.top){
                self.bgColor
                    .frame(width:geometry.size.width,height: geometry.safeAreaInsets.top+44)
                .overlay(
                    GeometryReader{ geometry in
                        HStack{
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                            Spacer()
                            Text(self.user.nickname)
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                        }.padding(15)
                    }
                    .frame(width:geometry.size.width,height:44)
                    ,alignment: .bottom
                )
            }
            .opacity(self.opacity)
            .frame(height:geometry.size.height,alignment: .top)
        }
    }
    
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
    
    var opacity: Double {
        switch scrollOffset {
        case -180...0:
            return 0
        case (-280)..<(-180):
            return Double(-scrollOffset-180) / 100.0
        case (-999)..<(-240):
            return 1
        default:
            return 0
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user:TestUserList[0],leftPercent: 0)
    }
}
