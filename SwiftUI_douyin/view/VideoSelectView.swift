//
//  HomeNavigationBar.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

private let VideoSelectWidth:CGFloat = UIScreen.main.bounds.width/2
private let ButtonHeight:CGFloat = 32
private let GapHeight:CGFloat = 15
private let VideoSelectHeight:CGFloat = GapHeight+ButtonHeight+2


private struct SelectButtonView :View{
    let text:String
    let action:()->Void
    var body: some View{
        Button(action: {
            withAnimation{
                self.action()
            }
        }) {
            Text(text)
                .frame(width:VideoSelectWidth,height:ButtonHeight)
        }
    }
}

struct VideoSelectView: View {
    
    let videoCount:Int
    let likeCount:Int
    
    @Binding var leftPercent:CGFloat //0左,1右
    
    
    var body: some View {
        VStack(spacing:0){
            
            Spacer()
                .frame(height:GapHeight)

            HStack(spacing:0){
                SelectButtonView(text: "作品 \(videoCount)") {
                    self.leftPercent = 0.0
                }
                .opacity(Double(1-self.leftPercent*0.5))
                
                SelectButtonView(text: "喜欢 \(likeCount)") {
                    self.leftPercent = 1.0
                }
                .opacity(Double(0.5+self.leftPercent*0.5))
            }
            .font(.system(size: 17))
            .foregroundColor(.white)
            .frame(height:ButtonHeight)
            
        
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.yellow)
                .frame(width:VideoSelectWidth,height:2)
                .offset(x:VideoSelectWidth*2*(self.leftPercent-0.5)+VideoSelectWidth*(0.5-self.leftPercent))
            
            Divider()
        }
        .frame(width:UIScreen.main.bounds.width,height:VideoSelectHeight)
    }
}

struct VideoSelect_Previews: PreviewProvider {
    static var previews: some View {
        VideoSelectView(videoCount: 1,
                    likeCount: 2,
                    leftPercent:.constant(0.0))
        .background(Color.black)
    }
}
