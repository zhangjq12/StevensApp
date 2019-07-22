//
//  ArticleViewController.swift
//  stevens
//
//  Created by 张家骞 on 7/14/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x:5,y:kNavBarHeight,width:UIScreen.main.bounds.width,height:200))
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        //label.frame = CGRect(x:20,y:30,width:130,height:40)
        //label.text = "Hello!"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        let htmlString = """
                            <html><head></head><body><h1>Hello World!</h1><img src="http://img5.duitang.com/uploads/item/201209/10/20120910111702_CNPJj.thumb.700_0.jpeg" height="100" width="100"></img><p>Good!</p></body></html>
                        """

        label.attributedText = htmlString.htmlToAttributedString;
        
        self.view.addSubview(label)
        self.view.addSubview(contentView)
        // Do any additional setup after loading the view.
    }
    
    lazy var contentView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.itemSize = CGSize(width: kWidth, height: 100.33)
        //layout.scrollDirection = .vertical
        
        let tabbarSpace: CGFloat = (self.tabBarController?.tabBar.frame.height)!
        
        let contentView = UICollectionView.init(frame: CGRect.init(x: 0.0, y: 200.0 + kNavBarHeight, width: kWidth, height: kHeight - tabbarSpace - kBottomSpace), collectionViewLayout: layout)
        contentView.dataSource = self
        contentView.delegate = self
        contentView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "contentCell")
        contentView.backgroundColor = UIColor.white
        
        return contentView
    }()
    
    func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat,lineSpacing:CGFloat=0) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: width, height: 9999)
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        let attributes = [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle: paraph]
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return strSize.height
        
    }

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension ArticleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ contentView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in contentView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ contentView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ contentView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = contentView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath)
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        //cell.backgroundColor = UIColor.randomColor
        return cell
    }
    
    func collectionView(_ contentView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false;
    }
}

/*extension UIImageView{
    func downloadedFrom(imageurl : String){
        let url = URL(string: imageurl)!
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                DispatchQueue.main.async {
                    self.image = UIImage(named: "noData")
                }
            }else{
                let img = UIImage(data:data!)
                DispatchQueue.main.async {
                    self.image = img
                }
                
            }
        }) as URLSessionTask
        dataTask.resume()
    }
}*/

