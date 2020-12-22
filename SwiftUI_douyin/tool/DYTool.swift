
//
//  DYTool.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/22.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
//import SDWebImageSwiftUI

private struct DUserList : Codable {
    let list:[DUser]
}

//最好还是使用第三方来处理,这里json解析出了问题不容易找到
func loadListData(_ fileName:String)->[DUser]{
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can not findd \(fileName) in main bundle")
    }
    guard let data = try? Data(contentsOf: url) else{
        fatalError("Can not load \(url)")
    }
    guard let list = try? JSONDecoder().decode(DUserList.self, from: data) else {
        fatalError("Can not parse post list json data")
    }
    return list.list
}

func loadImage(_ name:String)->Image{
//    print(NetworkAPIBaseURL+name)
//    return WebImage(url: URL(string:NetworkAPIBaseURL+name))
//        .placeholder{ Color.gray }
//        .resizable()
    return Image(uiImage: UIImage(named: name)!)
}
