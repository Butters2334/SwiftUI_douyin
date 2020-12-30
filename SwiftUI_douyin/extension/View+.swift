//
//  View+.swift
//  SwiftUI_douyin
//
//  Created by ac on 2020/12/30.
//  Copyright © 2020 ancc. All rights reserved.
//

import SwiftUI

extension View{
    public func addView<Overlay>(alignment: Alignment = .center,@ViewBuilder _ overlay: ()->Overlay) -> some View where Overlay : View{
        self.overlay(overlay(), alignment: alignment)
    }
    public func setBackground<Overlay>(alignment: Alignment = .center,@ViewBuilder _ overlay: ()->Overlay) -> some View where Overlay : View{
        self.background(overlay(), alignment: alignment)
    }
}
