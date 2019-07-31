//
//  MyInfoView.swift
//  stevens
//
//  Created by 张家骞 on 7/30/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

class MyInfoView: UITableViewController {

    @IBOutlet var MyInfoTable: UITableView!
    @IBOutlet weak var messageBadge: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        messageBadge.showBadgeValue(strBadgeValue: "0")
        // Do any additional setup after loading the view.
        
    }
    
    override func tableView(_ MyInfoTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = UserView()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        if indexPath.section == 1 {
            if indexPath.row == 2 {
                let vc = MessageView()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else
        if indexPath.section == 2{
            let vc = AppSettingsView()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView{
    func showBadgeValue(strBadgeValue: String) -> Void{
        
        let tabBar = UITabBar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let item = UITabBarItem(title: "", image: nil, tag: 0)
        item.badgeValue = strBadgeValue
        let array = [item]
        
        tabBar.items = array
        for viewTab in tabBar.subviews{
            for subview in viewTab.subviews{
                let strClassName = String(utf8String: object_getClassName(subview))
                if strClassName == "UITabBarButtonBadge" || strClassName == "_UIBadgeView"{
                    let theSubView = subview
                    theSubView.removeFromSuperview()
                    self.addSubview(theSubView)
                    theSubView.frame = CGRect(x: self.frame.size.width - theSubView.frame.size.width, y: 0, width: theSubView.frame.size.width, height: theSubView.frame.size.height)
                    
                }
                
            }
        }
    }
    
    //删除UIView的badge
    func removeBadge() -> Void{
        for subview in self.subviews{
            let strClassName = String(utf8String: object_getClassName(subview))
            if strClassName == "UITabBarButtonBadge" || strClassName == "_UIBadgeView"{
                let theSubView = subview
                theSubView.removeFromSuperview()
            }
        }
    }
}
