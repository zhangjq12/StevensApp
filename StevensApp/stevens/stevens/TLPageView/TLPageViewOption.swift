//
//  TLPageViewOption.swift
//  PageMenuCustom
//
//  Created by 张家骞 on 7/11/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

public enum TLPageViewOption {
    case menuHeight(CGFloat)
    
    case menuBottmonLineHeight(CGFloat)
    case menuBottomLineColor(UIColor)
    
    case menuItemFont(UIFont)
    case menuItemColor(UIColor)
    case menuItemSelectedColor(UIColor)
    case menuItemMargin(CGFloat)
    
    case leftItem(UIView)
    case rightItem(UIView)
    
    case separatorLineColor(UIColor)
    case separatorLineHeight(CGFloat)
    
    case menuBackgroundColor(UIColor)
}
