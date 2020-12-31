//
//  ActionDemo.swift
//  SwiftUICode
//
//  Created by ac on 2020/12/16.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

struct AlertButton: View{
    let buttonLabel:Text
    let title: Text
    var message: Text? = nil
    var buttons: [Alert.Button] = [.cancel()]
    init(_ label:Text,title:Text,message:Text?=nil,buttons: [ActionSheet.Button] = [.cancel()]) {
        self.buttonLabel = label
        self.title = title
        self.message = message
        self.buttons = buttons
    }
    @State private var isPresented = false
    var body: some View{
        Button(action: {
            self.isPresented = true
        },label:{buttonLabel})
            .alert(isPresented: $isPresented){
                if buttons.count >= 2 {
                    return Alert(
                                title:title,
                                message:message,
                                primaryButton: buttons[0],
                                secondaryButton: buttons[1])
                }else{
                    return Alert(
                                title:title,
                                message:message,
                                dismissButton: buttons[0])
                }
        }
    }
}


struct ActionSheetButton: View{
    let buttonLabel:Text
    let title: Text
    var message: Text? = nil
    var buttons: [ActionSheet.Button] = [.cancel()]
    init(_ label:Text,title:Text,message:Text?=nil,buttons: [ActionSheet.Button] = [.cancel()]) {
        self.buttonLabel = label
        self.title = title
        self.message = message
        self.buttons = buttons
    }
    @State private var isPresented = false
    var body: some View{
        Button(action: {
            self.isPresented = true
        },label:{buttonLabel})
            .actionSheet(isPresented: $isPresented){
                ActionSheet(title:title, message:message, buttons:buttons)
        }
    }
}

struct SheetButton<Content>: View where Content : View{
    let label:Text
    let content:()->Content
    init(_ label:Text,content:@escaping ()->Content) {
        self.label = label
        self.content = content
    }
    @State private var isPresented = false
    var body: some View{
        Button(action: {
            self.isPresented = true
        },label:{label})
        .sheet(isPresented: $isPresented,
               content: self.content)
    }
}
