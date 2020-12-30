//
//  UserContent.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/24.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

private struct UserHeadView:View {
    let user:DUser
    let bgColor : Color
    var body: some View{
        HStack(spacing: 15){
            loadImage(user.avatar)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 90, height: 90)
                .overlay(
                    Circle()
                    .stroke(bgColor, lineWidth: 1.5)
                )
                .padding(.top,-15)

            HStack(spacing:8){
                GeometryReader { geometry in
                    Button(action: {
                        print("关注")
                    }) {
                        HStack(spacing:5){
                            Image(systemName: "plus")
                                .font(.system(size: 17, weight: .regular))
                            Text("关注")
                                .font(.system(size: 15))
                                .bold()
                        }
                    }
                    .frame(width:geometry.size.width,height:40)
                    .background(Color.pink)
                }
                
                Button(action: {
                    print("私信")
                }) {
//                    Text("私信")
//                        .font(.system(size: 15))
//                        .bold()
                    Image(systemName: "chevron.down")
                }
                .frame(width:40,height:40)
                .background(Color.gray.opacity(0.3))
            }
            .foregroundColor(.white)
            .frame(height:40)
        }
    }
}

private struct UserTagsView:View {
    let user:DUser
    func genderColor(gender:Int)->Color{
        switch gender {
        case 0:return Color.pink.opacity(0.8)
        case 1:return Color.blue.opacity(0.8)
        default:return Color.white.opacity(0.4)
        }
    }
    var body: some View{
        HStack{
            Group{
                HStack(alignment:.lastTextBaseline,spacing:3){
                    Image(systemName: "person.fill")
                        .foregroundColor(genderColor(gender: user.gender ?? -1))
                    Text("\(user.age ?? 0)岁")
                }
                if user.addr.count > 0 {
                    Text("\(user.addr.joined(separator: "·"))")
                }
                ForEach(user.tag,id:\.self){
                    Text("\($0)")
                }
//                ForEach(user.tag,id:\.self){
//                    Text("\($0)")
//                }
            }
            .font(.system(size: 13))
            .foregroundColor(Color.white.opacity(0.4))
            .frame(minWidth:30)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(
                RoundedRectangle(cornerRadius:3)
                    .foregroundColor(Color.gray.opacity(0.2))
            )
        }
    }
}

private struct UserFansView:View {
    let user    : DUser
    var body: some View{
        HStack(alignment:.lastTextBaseline,spacing:3){
            numText("\(user.get_thumbs_count.countText)")
            descText("获赞")
            Spacer().frame(width:10)
            numText("\(user.following_count.countText)")
            descText("关注")
            Spacer().frame(width:10)
            numText("\(user.follower_count.countText)")
            descText("粉丝")
        }
    }
    func numText(_ text:String)->Text{
        Text(text)
            .font(.system(size: 21))
            .bold()
    }
    func descText(_ text:String)->Text{
        Text(text)
            .font(.system(size: 13))
            .foregroundColor(.gray)
    }
}

struct UserContentView: View {
    let user    : DUser
    let bgColor : Color
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            //头像和关注按钮
            UserHeadView(user:user,bgColor: bgColor)
            //名称和昵称
            Text(user.nickname)
                .font(.system(size: 24))
                .bold()
            HStack(spacing:5){
                Text("抖音号：\(user.short_id)")
                    .font(.system(size: 14))
                    .italic()
                Image(systemName: "doc.on.clipboard.fill")
                    .font(.system(size: 12))
                    .foregroundColor(Color.white.opacity(0.3))
            }
            .foregroundColor(.gray)
            
            Divider()
            
            //签名
            Text(user.personalSign)
                .font(.system(size: 15))
                .lineSpacing(5)
            //标签
            UserTagsView(user: user)
            //获赞关注粉丝
            UserFansView(user: user)
        }
        .foregroundColor(Color.white.opacity(0.85))
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15))
        .background(bgColor)
    }
}

struct UserContent_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView(user: TestUserList[0],bgColor: colorRGB(0x151823))
    }
}
