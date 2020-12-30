//
//  UserNavigationView.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct UserNavigationView: View {
    let bgColor:Color
    let nickname:String
    @Binding var scrollOffset:CGFloat
    var body: some View {
        GeometryReader{ geometry in
            HStack(alignment:.top){
                self.bgColor
                    .frame(width:geometry.size.width,
                           height: geometry.safeAreaInsets.top+44)
                .overlay(
                        HStack{
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                            Spacer()
                            Text(self.nickname)
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                        }.padding(15)
                    .frame(width:geometry.size.width,height:44)
                    ,alignment: .bottom
                )
            }
            .opacity(self.opacity)
            .frame(height:geometry.size.height,alignment: .top)
        }
    }
    //导航栏透明效果
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

struct UserNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        UserNavigationView(bgColor: .black,
                           nickname: "nickname",
                           scrollOffset: .constant(-280))
    }
}
