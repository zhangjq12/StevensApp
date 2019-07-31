//
//  ZXPopView.swift
//  stevens
//
//  Created by 张家骞 on 7/31/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

class ZXPopView: UIView {

    var contenView:UIView?
    {
        didSet{
            setUpContent()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContent(){
        
        if self.contenView != nil {
            self.contenView?.frame.origin.y = self.bounds.height
            self.addSubview(self.contenView!)
        }
        self.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissView)))
        
    }
    
    
    @objc func dismissView(){
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (true) in
            self.removeFromSuperview()
            self.contenView?.removeFromSuperview()
        }
    }
    func showInView(view:UIView){
        if (view == nil && contenView == nil) {
            return
        }
        
        view.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
            self.contenView?.bounds.origin.y = self.bounds.height-(self.contenView?.bounds.height)!
        }, completion: nil)
    }
    
    func showInWindow(){
        
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
            self.contenView?.bounds.origin.y = self.bounds.height-(self.contenView?.bounds.height)!
        }, completion: nil)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
