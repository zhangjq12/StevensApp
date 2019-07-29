//
//  ViewController.swift
//  stevens
//
//  Created by 张家骞 on 7/11/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//Github commit test
//

import UIKit

var kReadedNewsKey = "ReadNewsKey"

class ViewController: UIViewController {

    var pageView: TLPageView!
    var titles : [String] = ["Recommend", "House Rental", "Car Trade", "Internship", "Popular Restaurant"]
    lazy var rightItem: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        btn .addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.setImage(UIImage(named: "More"), for: .normal)
        btn.setImage(UIImage(named: "More"), for: .highlighted)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        
        var controllers = [UIViewController]()
        for i in 0..<5{
            let controller = FourmController()
            controller.title = titles[i]
            controllers.append(controller)
        }
        
        pageView = TLPageView(viewControllers: controllers, pageViewOptions: [.menuHeight(50),
                                                                              .menuItemMargin(5),
                                                                              .menuItemFont(UIFont.systemFont(ofSize: 15)),
                                                                              .menuItemColor(UIColor(red: 146 / 255.0, green: 146 / 255.0, blue: 146 / 255.0, alpha: 1.0)),
                                                                              .menuItemSelectedColor(UIColor(red: 33 / 255.0, green: 33 / 255.0, blue: 33 / 255.0, alpha: 1.0)),
                                                                              .rightItem(rightItem)])
        //        pageView.currentIndex = 1
        view.addSubview(pageView)
        pageView.frame = CGRect(x: 0, y: 88, width: view.frame.size.width, height: view.frame.size.height - 88)
        
        pageView.moveTo(index: 0, animated: false)

    }
    
    @objc private func btnClick() {
        //        print("More button clicked")
        //        let vc = DemoController()
        //        vc.title = "替换"
        //        vc.view.backgroundColor = .black
        //
        //        pageView.replace(viewController: vc, at: 1)
        pageView.moveTo(index: 2, animated: true)
    }
    
}
