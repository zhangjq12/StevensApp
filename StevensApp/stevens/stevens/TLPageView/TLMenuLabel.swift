//
//  TLMenuLabel.swift
//  PageMenuCustom
//
//  Created by 张家骞 on 7/11/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

class TLMenuLabel: UILabel {
    /// 用来记录当前 label 的缩放比例
    var currentScale: CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
}
