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
    var body: some View {
        ScrollView{
            VStack(spacing:0){
                loadImage(user.user_bg)
                .resizable()
                .scaledToFill()
                .frame(height:100)
                
                UserContent(user: user, bgColor: bgColor)
                
                VideoList(videoData: user.sort_video_list)
            }
        }
        .gesture(DragGesture().onChanged({ value in
            print(value)
        }))
        .edgesIgnoringSafeArea(.top)
        .background(bgColor)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user:TestUserList[0])
    }
}
