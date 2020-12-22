//
//  DStatistics.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import Foundation

//json映射
struct DStatistics :Codable{
    var aweme_id: String            //视频id
    let play_count:Int           //观看数量
    let comment_count:Int        //评论数量
    let share_count:Int          //分享数量
    let digg_count:Int           //喜欢的数量
}

//序列化
extension DStatistics: Identifiable {
    var id: Int {
        Int(self.aweme_id) ?? 0
    }
}
