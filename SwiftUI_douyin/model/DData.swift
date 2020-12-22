//
//  DYData.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

//本地测试数据
var TestUserList = loadListData("user.json")


extension Int {
    //简化量级
    var countText:String{
        if self < 1000 {
            return "\(self)"
        }
        if self > 10000 {
            return String(format:"%.1fw",Double(self)/10000)
        }
        return String(format:"%.1fk",Double(self)/1000)
    }
}
