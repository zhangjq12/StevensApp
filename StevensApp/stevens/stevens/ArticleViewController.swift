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
        //let htmlString = """
                           // <html><head></head><body><h1>Hello World!</h1><img src="
        //http://img5.duitang.com/uploads/item/201209/10/20120910111702_CNPJj.thumb.700_0.jpeg
        //" height="100" width="100"></img><p>Good!</p></body></html>
                        //"""

        //label.attributedText = htmlString.htmlToAttributedString;
        
        let contentText = "Hello! Welcome to my new page!\n<b>This is my home page!</b>\n<img>logo</img>\nI Love You All!"
        label.frame = CGRect(x: 5, y: kNavBarHeight + 5, width: UIScreen.main.bounds.width - 10, height: getLabHeigh(labelStr: contentText, font: label.font, width: UIScreen.main.bounds.width))
        //label.attributedText = NSMutableAttributedString(string: contentText)
        label.attributedText = formatTransfer(labelStr: contentText)
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
    
    func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat,lineSpacing:CGFloat = 0) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: width, height: 9999)
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        let attributes = [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle: paraph]
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return strSize.height
        
    }
    func formatTransfer(labelStr: String) -> NSAttributedString {
        let attrStr: NSMutableAttributedString = NSMutableAttributedString()
        var imageStr: String = ""
        var specialStr: String = ""
        var attrStrPart: String = ""
        var originStr: String = ""
        var special: Bool = false
        var img: Bool = false
        var attrBoo: Bool = false
        //var startIndex: Int = 0
        for index in 0..<labelStr.count {
            let Index = labelStr.index(labelStr.startIndex, offsetBy: index)
            if labelStr[Index] == "<" {
                if originStr != "" {
                    attrStr.append(NSMutableAttributedString(string: originStr))
                    originStr = ""
                }
                special = true
            }
            else
                if labelStr[Index] == ">" {
                    special = false
                    switch specialStr {
                    case "img":
                        img = true
                        break
                    case "/img":
                        let image : UIImage = UIImage(named: imageStr)!
                        let textAttachment : NSTextAttachment = NSTextAttachment()
                        textAttachment.image = image
                        if image.size.width < label.frame.width {
                            textAttachment.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                        }
                        else {
                            textAttachment.bounds = CGRect(x: 0, y: 0, width: label.frame.width, height: image.size.height/image.size.width*label.frame.width)
                        }
                        attrStr.append(NSAttributedString(attachment: textAttachment))
                        imageStr = ""
                        img = false
                        break
                    case "b":
                        attrBoo = true
                        break
                    case "/b":
                        let attr = NSMutableAttributedString(string: attrStrPart)
                        attr.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], range: NSRange(location: 0, length: attr.length))
                        attrStr.append(attr)
                        attrStrPart = ""
                        attrBoo = false
                        break
                    default:
                        break
                    }
                    specialStr = ""
            }
            else {
                if special {
                    specialStr.append(labelStr[Index])
                }
                else
                    if img {
                        imageStr.append(labelStr[Index])
                }
                else
                    if attrBoo {
                        attrStrPart.append(labelStr[Index])
                    }
                    else {
                        originStr.append(labelStr[Index])
                }
            }
        }
        if originStr != "" {
            attrStr.append(NSMutableAttributedString(string: originStr))
            originStr = ""
        }
        
        return attrStr
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

