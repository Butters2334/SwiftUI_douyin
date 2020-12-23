//
//  ContentView.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/21.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        ScrollView{
            Text("data = \(String(reflecting:TestUserList[0]))")
//            AVCaptureVideoPreviewLayer()()
        }
    }
} 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
