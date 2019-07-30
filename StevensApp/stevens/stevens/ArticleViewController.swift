//
//  ArticleViewController.swift
//  stevens
//
//  Created by 张家骞 on 7/14/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    lazy var label: UITextView = {
        let label = UITextView(frame: CGRect(x: 5, y: kNavBarHeight, width: UIScreen.main.bounds.width - 20, height:999999))
        //label.lineBreakMode = NSLineBreakMode.byWordWrapping
        //label.numberOfLines = 0
        label.isEditable = false
        label.isSelectable = false
        label.alwaysBounceVertical = false
        label.layoutManager.allowsNonContiguousLayout = false
        label.isScrollEnabled = false
        label.dataDetectorTypes = UIDataDetectorTypes.link
        //label.backgroundColor = .red
        return label
    }()
    
    lazy var ScrollView: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: kNavBarHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scroll.contentSize = CGSize(width: scroll.bounds.width, height: scroll.bounds.height * 10)
        return scroll
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
        
        let contentText = "Hello! Welcome to my new page!HAHAHAHAHAHAHAHAHAHAH\n<b>This is my home page!\n</b><img>http://img5.duitang.com/uploads/item/201209/10/20120910111702_CNPJj.thumb.700_0.jpeg</img>\nI Love You All!\nLove You!\n<img>http://pic.rmb.bdstatic.com/f54083119edfb83c4cfe9ce2eeebc076.jpeg</img>\n<img>noData</img>\nGOOD!\n<img>http://img3.imgtn.bdimg.com/it/u=1656811409,1242727312&fm=26&gp=0.jpg</img>\n<img>wow</img>\n<img>http://upload.pig66.com/uploadfile/2017/0511/20170511080327163.jpg</img>"
        //label.frame = CGRect(x: 5, y: kNavBarHeight + 5, width: UIScreen.main.bounds.width - 10, height: getLabHeigh(labelStr: contentText, font: label.font, width: UIScreen.main.bounds.width))
        //label.attributedText = NSMutableAttributedString(string: contentText)
        let attributedContent = formatTransfer(labelStr: contentText)
        let strRec = attributedContent.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 20, height: CGFloat(MAXFLOAT)), options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil)
        let height = strRec.height + 20
        label.attributedText = attributedContent
        label.frame = CGRect(x: 5, y: kNavBarHeight, width: UIScreen.main.bounds.width - 20, height: height)
        ScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: height + replyView.bounds.height)
        self.view.addSubview(ScrollView)
        self.ScrollView.addSubview(label)
        self.ScrollView.addSubview(replyView)
        // Do any additional setup after loading the view.
    }
    
    lazy var replyView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.itemSize = CGSize(width: kWidth, height: 180)
        layout.headerReferenceSize = CGSize(width: kWidth, height: 40)
        //layout.scrollDirection = .vertical
        
        let tabbarSpace: CGFloat = (self.tabBarController?.tabBar.frame.height)!
        
        let contentView = UICollectionView.init(frame: CGRect.init(x: 0.0, y: kNavBarHeight + label.frame.height, width: kWidth, height: kHeight - tabbarSpace - kBottomSpace), collectionViewLayout: layout)
        contentView.dataSource = self
        contentView.delegate = self
        contentView.register(ReplyCell.self, forCellWithReuseIdentifier: "ReplyCell")
        contentView.register(ReplyHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ReplyHeader")
        contentView.backgroundColor = UIColor.white
        
        return contentView
    }()
    
    /*func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat,lineSpacing:CGFloat = 0) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: width, height: 9999)
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = lineSpacing
        let attributes = [NSAttributedString.Key.font:font,NSAttributedString.Key.paragraphStyle: paraph]
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return strSize.height
        
    }*/
    
    func formatTransfer(labelStr: String) -> NSAttributedString {
        let attrStr: NSMutableAttributedString = NSMutableAttributedString()
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 8
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
                    paraph.alignment = .left
                    let attr = NSMutableAttributedString(string: originStr)
                    attr.addAttributes([NSAttributedString.Key.paragraphStyle: paraph, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], range: NSRange(location: 0, length: attr.length))
                    attrStr.append(attr)
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
                        let image : UIImage = downloadedFrom(imageurl: imageStr)
                        let textAttachment : NSTextAttachment = NSTextAttachment()
                        textAttachment.image = image
                        if image.size.width < label.frame.width - 5 {
                            textAttachment.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                        }
                        else {
                            textAttachment.bounds = CGRect(x: 0, y: 0, width: label.frame.width - 5, height: image.size.height/image.size.width*(label.frame.width - 5))
                        }
                        let attr = NSMutableAttributedString(attachment: textAttachment)
                        paraph.alignment = .center
                        attr.addAttributes([NSAttributedString.Key.paragraphStyle: paraph, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], range: NSRange(location: 0, length: attr.length))
                        attrStr.append(attr)
                        imageStr = ""
                        img = false
                        break
                    case "b":
                        attrBoo = true
                        break
                    case "/b":
                        paraph.alignment = .left
                        let attr = NSMutableAttributedString(string: attrStrPart)
                        attr.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.paragraphStyle: paraph], range: NSRange(location: 0, length: attr.length))
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
            paraph.alignment = .left
            let attr = NSMutableAttributedString(string: originStr)
            attr.addAttributes([NSAttributedString.Key.paragraphStyle: paraph, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], range: NSRange(location: 0, length: attr.length))
            attrStr.append(attr)
            originStr = ""
        }
        
        return attrStr
    }
    
     func downloadedFrom(imageurl : String) -> UIImage{
        var image: UIImage? = UIImage.init()
        let url = NSURL(string: imageurl)!
        let data = NSData(contentsOf: url as URL)
        let boo: Bool = data === nil
        if !boo {
            image = UIImage(data: data! as Data)
        }
        else {
            image = UIImage(named: "noData")
        }
        return image!
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
    
    func collectionView(_ replyView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in replyView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ replyView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ replyView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
    }
    
    func collectionView(_ replyView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = replyView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ReplyHeader", for: indexPath) as! ReplyHeaderCell
        headerView.label.text = "Reply"
        return headerView
    }
    
    func collectionView(_ replyView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = replyView.dequeueReusableCell(withReuseIdentifier: "ReplyCell", for: indexPath) as! ReplyCell
        //cell.backgroundColor = UIColor.randomColor
        cell.userLabel.text = "User1"
        cell.replyContent.text = "HAHAHAHAHAHAHHAHAHAHAHAHAHAHAHAHAHAHAHAHHAAH\nHAHAHAHAHAHAHAHAHAHHAHA\nHAHAHAHAHAHA"
        return cell
    }
    
    func collectionView(_ contentView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false;
    }
}
