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
    
    @State private var scrollOffset: CGFloat = 0
    var body: some View {
        ZStack(alignment: .top) {
            bgView
            scrollView
            statusBarView
        }
        .edgesIgnoringSafeArea(.top)
        .background(bgColor)
    }
    
    var  bgView : some View{
        loadImage(self.user.user_bg)
            .resizable()
            .scaledToFill()
            .frame(height:140)
//            .padding(min(-self.scrollOffset,0))
            .padding(self.padding)
    }
    
    var scrollView: some View {
        ScrollViewOffset(onOffsetChange: {
            self.scrollOffset = $0
        }, content: {
            VStack(alignment:.center,spacing:0){
                Color.clear.frame(height:100)

                UserContent(user: self.user, bgColor: self.bgColor)
                
                VideoList(videoData: self.user.sort_video_list)
            }
        })
    }
    
    var statusBarView: some View {
        GeometryReader { geometry in
            Color.red
                .opacity(self.opacity)
                .frame(height: geometry.safeAreaInsets.top+44)
        }
    }
    
    var padding:EdgeInsets {
        let gap = CGFloat(60.0)
        if scrollOffset <= gap {
            return EdgeInsets()
        }
        let offset = -scrollOffset + gap
        return EdgeInsets(top: offset * -1.2,
                          leading: offset,
                          bottom: offset,
                          trailing: offset)
    }
    
    var opacity: Double {
        switch scrollOffset {
        case -100...0:
            return Double(-scrollOffset) / 100.0
        case ...(-100):
            return 1
        default:
            return 0
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user:TestUserList[0])
    }
}
