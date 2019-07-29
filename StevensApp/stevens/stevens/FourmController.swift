//
//  DemoController.swift
//  Exampel
//
//  Created by Charles on 2018/7/12.
//  Copyright © 2018 Charles. All rights reserved.
//

import UIKit

let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height
let kNavBarHeight: CGFloat = kHeight > 736.0 ? (88.0) : (64.0)
let kWindow = UIApplication.shared.keyWindow
let kRootVC = kWindow?.rootViewController
let kBottomSpace: CGFloat = kHeight > 736.0 ? (54.0) : (0.0)

class FourmController: UIViewController {
    
    lazy var collection: UICollectionView = UICollectionView()
    var data: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let desc = UILabel()
        desc.text = self.title
        desc.frame = CGRect(x: 50, y: 200, width: 100, height: 30)
        view.addSubview(desc)*/

        /*tableView.frame = view.frame
        tableView.backgroundColor = .white
        view.addSubview(tableView)*/
        self.view.addSubview(self.collectionView)
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            if touch.view !== self.collectionView {
                return false
            }else {
                return true
            }
        }
        
        self.collectionView.addHeaderRefresh {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
                
                self.data.removeAll()
                self.data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
                self.collectionView.footerResetNoDataState()
                self.collectionView.reloadData_ASP {
                    self.collectionView.headerBeginRefreshing()
                }
                
            })
        }
        self.collectionView.addFooterRefresh {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
                
                for _ in 0...1 {
                    let ori = self.data[self.data.count - 1]
                    var num: Int? = Int(ori)
                    num! += 1
                    let str = String(num!)
                    self.data.append(str)
                }
                self.collectionView.reloadData_ASP()
                if self.data.count > 17 {
                    self.collectionView.footerEndRefrshWithNoData()
                }
            })
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear == " + (navigationItem.title ?? ""))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear == " + (navigationItem.title ?? ""))

    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.itemSize = CGSize(width: kWidth, height: 100.33)
        //layout.scrollDirection = .vertical
        
        let tabbarSpace: CGFloat = (self.tabBarController?.tabBar.frame.height)!
        
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: kWidth, height: kHeight - tabbarSpace - kBottomSpace), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()

}

extension FourmController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ArticleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        //cell.backgroundColor = UIColor.randomColor
        let str = "No." + data[indexPath.row] + " News is: GOOD MORNING EVERY ONE, THIS IS NO." + data[indexPath.row] + " NEWS, and I'd like you to click it"
        let strRec = str.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 105, height: 100000), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], context: nil)
        let height = strRec.height
        cell.label.text = str
        cell.label.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 105, height: height)
        cell.hotLabel.text = "0"
        cell.likeLabel.text = "0"
        cell.commentLabel.text = "0"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true;
    }
}
