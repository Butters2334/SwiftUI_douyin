//
//  DVideo.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import Foundation
import UIKit

//json映射
struct DVideo :Codable{
    var aweme_id: String
    let desc:String
    let author_user_id:String
    let video:String            //视频地址/或本地视频名称
    let cover:String            //视频大图
    let music:String?
    let author:String?
    let statistics:DStatistics
}

//序列化
extension DVideo: Identifiable {
    var id: Int {
        Int(self.aweme_id) ?? 0
    }
}

//简单判断
extension DVideo: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool{
        lhs.id == rhs.id
    }
}

//用于UI显示
extension DVideo{
    var coverSize:CGSize {
        CGSize(width: UIScreen.main.bounds.width/3, height: 170)
    }
}
