//
//  ReplyHeaderCell.swift
//  stevens
//
//  Created by 张家骞 on 7/30/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

class ReplyHeaderCell: UICollectionReusableView {
    
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .lightGray
        
        self.label = UILabel(frame: CGRect(x: 10, y: 0, width: 50, height: 40))
        self.label.font = UIFont.boldSystemFont(ofSize: 17)
        self.addSubview(self.label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
