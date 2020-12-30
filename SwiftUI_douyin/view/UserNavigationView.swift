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
    let backTap:()->Void
    let moreTap:()->Void
    var body: some View {
        GeometryReader{ geometry in
            HStack(alignment:.top){
                self.navgationView(geometry: geometry)
            }
            .frame(height:geometry.size.height,alignment: .top)
        }
    }
    func navgationView(geometry:GeometryProxy) -> some View {
        let safeTop = geometry.safeAreaInsets.top
        let viewWidth = geometry.size.width
        let statusHeight:CGFloat = 44.0
        return Rectangle()
            .frame(width: viewWidth, height: safeTop+statusHeight)
            .foregroundColor(self.bgColor.opacity(self.opacity))
            .addView(alignment: .bottom){
                self.defaultView
                    .frame(width:viewWidth,height:statusHeight)
                    .opacity(1-self.opacity)
            }
            .addView(alignment: .bottom){
                self.statusView
                    .frame(width:viewWidth,height:statusHeight)
                    .opacity(self.opacity)
            }
    }
    var statusView: some View{
        HStack{
            backBtn
            Spacer()
            titleText
            Spacer()
            moreBtn
        }.padding(15)
    }
    var defaultView: some View {
        HStack{
            backBtn.setBackground {butBg}
            Spacer()
            moreBtn.setBackground {butBg}
        }
        .padding(CGFloat(15 + 15.0 * (1-self.opacity)))
    }
    var backBtn : some View {
        Image(systemName: "chevron.left")
            .foregroundColor(.white)
            .onTapGesture(perform: backTap)
    }
    var titleText : some View {
        Text(self.nickname)
            .font(.system(size: 24))
            .bold()
            .foregroundColor(.white)
    }
    var moreBtn : some View {
        Image(systemName: "ellipsis")
            .foregroundColor(.white)
            .onTapGesture(perform: moreTap)
    }
    var butBg : some View {
        Circle()
            .frame(width:38,height:38)
            .foregroundColor(Color.gray.opacity(0.8))
        .opacity(1-self.opacity)
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

private struct UserNavigationView_Temp: View {
    @State var scrollOffset:CGFloat = -180
    var body: some View {
        VStack{
            UserNavigationView(bgColor: colorRGB(0x151823),
                               nickname: "nickname",
                               scrollOffset:$scrollOffset,
                               backTap: {},
                               moreTap: {})
                .background(Color.black.opacity(0.3))
                .edgesIgnoringSafeArea(.all)
            Text("\(scrollOffset)")
            Slider(value:$scrollOffset,in: -300 ... -100)
                .padding(.bottom,30)
        }
    }
}

struct UserNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        UserNavigationView_Temp()
    }
}
