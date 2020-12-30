//
//  HScrollViewController.swift
//  WeiboDemo
//
//  Created by ac on 2020/11/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

/**
 *      封装UIScrollview的页面滑动功能给swiftUI使用
 *
 *      UIViewControllerRepresentable协议下面有make和update两个函数
 *      make:创建和封装uikit-view
 *      update:更新相关参数
 *      makeCoordinator:类似委托的处理
 *
 */
struct PageScrollView<Content:View>: UIViewControllerRepresentable {
    let pageWidth : CGFloat
    let contentSize : CGSize
    @Binding var leftPercent : CGFloat
    let content : Content
        
    init(pageWidth : CGFloat,
         contentSize : CGSize,
         leftPercent : Binding<CGFloat>,
         @ViewBuilder content : ()->Content){
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent
    }
    
    func makeUIViewController(context: Context) ->  UIViewController {
        //
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.isPagingEnabled = true
        scrollview.bounces = false
        scrollview.delegate = context.coordinator
        context.coordinator.scrollView = scrollview
            
        //
        let vc = UIViewController()
        vc.view.addSubview(scrollview)
        
        //将初始化传入的swiftUI封装为UIKit的vc,之后将vc添加到当前封装的vc上面
        let host = UIHostingController(rootView: content)
        vc.addChild(host)
        scrollview.addSubview(host.view)
        host.didMove(toParent: vc)
        context.coordinator.host = host
        
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollview = context.coordinator.scrollView!
        scrollview.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollview.contentSize = contentSize
        scrollview.setContentOffset(CGPoint(x: leftPercent*(contentSize.width-pageWidth), y: 0), animated: true)
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    class Coordinator : NSObject , UIScrollViewDelegate{
        let parent: PageScrollView
        var scrollView : UIScrollView!
        var host: UIHostingController<Content>!
        
        init(_ parent:PageScrollView){
            self.parent = parent
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation {
                parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth*0.5 ? 0 : 1
            }
        }
    }
}
