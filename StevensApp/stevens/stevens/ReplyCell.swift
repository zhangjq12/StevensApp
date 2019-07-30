//
//  ReplyCell.swift
//  stevens
//
//  Created by 张家骞 on 7/30/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

class ReplyCell: UICollectionViewCell {
    
    var userLabel: UILabel!
    var replyContent: UITextView!
    var likeBtn: UIButton!
    var replyBtn: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        userLabel = UILabel(frame: CGRect(x: 5, y: 5, width: self.frame.width - 10, height: 30))
        userLabel.font = UIFont.boldSystemFont(ofSize: 17)
        userLabel.numberOfLines = 1
        
        replyContent = UITextView(frame: CGRect(x: 15, y: 40, width: self.frame.width - 30, height: 100))
        replyContent.isEditable = false
        replyContent.isSelectable = false
        replyContent.alwaysBounceVertical = false
        replyContent.layoutManager.allowsNonContiguousLayout = false
        replyContent.isScrollEnabled = false
        replyContent.dataDetectorTypes = UIDataDetectorTypes.link
        
        likeBtn = UIButton(frame: CGRect(x: self.frame.width - 80, y: userLabel.frame.height + replyContent.frame.height + 15, width: 60, height: 20))
        likeBtn.setTitle("Like", for: .normal)
        likeBtn.setTitle("Liked", for: .highlighted)
        likeBtn.setTitle("Unused", for: .disabled)
        likeBtn.setTitleColor(.black, for: .normal)
        likeBtn.setTitleColor(.red, for: .highlighted)
        likeBtn.setTitleColor(.gray, for: .disabled)
        
        replyBtn = UIButton(frame: CGRect(x: self.frame.width - 160, y: userLabel.frame.height + replyContent.frame.height + 15, width: 60, height: 20))
        replyBtn.setTitle("Reply", for: .normal)
        replyBtn.setTitle("Reply", for: .highlighted)
        replyBtn.setTitle("Unused", for: .disabled)
        replyBtn.setTitleColor(.black, for: .normal)
        replyBtn.setTitleColor(.red, for: .highlighted)
        replyBtn.setTitleColor(.gray, for: .disabled)
        
        self.addSubview(userLabel)
        self.addSubview(replyContent)
        self.addSubview(likeBtn)
        self.addSubview(replyBtn)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
