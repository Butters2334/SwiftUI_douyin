//
//  DUser.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import UIKit

//json映射
struct DUser :Codable{
    let uid: String
    let short_id:String         //显示在页面上的短id
    let nickname:String         //用户名
    let avatar: String          //头像
    let user_bg:String          //个人页背景
    let gender: Int?             //性别0女1男
    let get_thumbs_count:Int    //获得的赞同
    let following_count:Int     //关注数量
    let follower_count:Int      //用户粉丝数量
    let video_list:[DVideo]     //已发布视频列表
    let isFollowed:Bool         //是否已关注
    let personalSign:String     //个性签名
    let age:Int?                //年龄
    let addr:[String]           //定位
    let tag:[String]            //标签
}

//序列化
extension DUser: Identifiable {
    var id: Int {
        Int(self.uid) ?? 0
    }
}

//简单判断
extension DUser: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool{
        lhs.id == rhs.id
    }
}

//用于UI显示
extension DUser{
    //将视频列表排序并分解为二维数组
    var sort_video_list:[[DVideo]]{
        matrix_video_list(
            video_list.sorted {
                (Int($0.aweme_id) ?? 0) > (Int($1.aweme_id) ?? 0)
            }
        )
    }
    var no_sort_video_list:[[DVideo]]{
        matrix_video_list(video_list)
    }
    func matrix_video_list(_ vl2:[DVideo])->[[DVideo]]{
        if vl2.count == 0{
            return [[]]
        }
        var sort_list:[[DVideo]] = []
        var temp_list:[DVideo] = []
        for data in vl2 {
            temp_list.append(data)
            if temp_list.count >= 3 || vl2.last == data {
                sort_list.append(temp_list)
                temp_list = []
            }
        }
        return sort_list
    }

    //发布视频数量
    var aweme_count:Int{
        video_list.count
    }
    //喜欢的短视频数量
    var favoriting_count:Int{
        favoriting.count
    }
    var favoriting:[DVideo]{
        []
    }
    
    //视频列表高度;找不到两个scrollview嵌套的办法,暂时计算高度来适配
    var video_view_height:CGFloat {
        if video_list.count > 0 {
            print(video_list[0].coverSize.height)
            print(CGFloat(video_list.count) / 3)
            print(ceil(CGFloat(video_list.count) / 3))
            print(video_list[0].coverSize.height * ceil(CGFloat(video_list.count) / 3))
            return video_list[0].coverSize.height * ceil(CGFloat(video_list.count) / 3)
        }
        return 100.0
    }
    
    var like_view_height:CGFloat {
        if favoriting.count > 0 {
            return favoriting[0].coverSize.height * ceil(CGFloat(favoriting.count) / 3)
        }
        return 100.0
    }
}

