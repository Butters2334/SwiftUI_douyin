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
    
    @State private var scrollOffset: CGFloat = .zero
    var body: some View {
        ZStack {
            scrollView
            statusBarView
        }
        .edgesIgnoringSafeArea(.top)
        .background(bgColor)
    }
    
    var scrollView: some View {
        ScrollViewOffset(onOffsetChange: {
            self.scrollOffset = $0
        }, content: {
            VStack(alignment:.center,spacing:0){
                ZStack{
                    loadImage(self.user.user_bg)
                        .resizable()
                        .scaledToFill()
                        .padding(-self.scrollOffset)
                }
                .frame(height:100)

                UserContent(user: self.user, bgColor: self.bgColor)
                
                VideoList(videoData: self.user.sort_video_list)
            }
        })
    }
    
    var statusBarView: some View {
        GeometryReader { geometry in
            Color.red
                .opacity(self.opacity)
                .frame(height: geometry.safeAreaInsets.top, alignment: .top)
                .edgesIgnoringSafeArea(.top)
        }
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
