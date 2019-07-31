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
        scroll.contentSize = CGSize(width: scroll.frame.width, height: scroll.frame.height * 10)
        return scroll
    }()
    
    let popview = ZXPopView.init(frame: UIScreen.main.bounds)

    let isXHeight = UIDevice.current.isX() ? 34 : 0
    
    let content = "很棒"
    var data: [String] = ["很棒"]
    //var countReply = 0.0;
    var textHeight = CGFloat(0)
    
    var ToolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: kHeight - 40, width: kWidth, height: 40))
    var HiddenToolBar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: kHeight - 40, width: kWidth, height: 40))
    
    let likeBtnView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    let likeBtn: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    let shareBtnView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    let shareBtn: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    let textView = UIView(frame: CGRect(x: 0, y: 0, width: kWidth - 70, height: 30))
    lazy var textField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 5, y: 0, width: kWidth - 85, height: 30))
        tf.delegate = self
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1..<10 {
            data.append(data[i - 1] + content)
        }
        ToolBar.frame.origin.y = kHeight - 40 - CGFloat(isXHeight)
        HiddenToolBar.frame.origin.y = kHeight - CGFloat(isXHeight)
        HiddenToolBar.frame.size.height = CGFloat(isXHeight)
        popview.contenView = UIView.init(frame: CGRect(x: 0, y: kHeight - 100, width: kWidth, height:100 ))
        popview.contenView?.backgroundColor = UIColor.orange
        
        self.view.backgroundColor = .white
        likeBtn.setImage(UIImage(named: "like"), for: UIControl.State.normal)
        shareBtn.setImage(UIImage(named: "share"), for: UIControl.State.normal)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textView.frame = CGRect(x: 0, y: 0, width: kWidth - shareBtnView.bounds.width - likeBtnView.bounds.width - 25, height: 30)
        textField.frame = CGRect(x: 5, y: 0, width: kWidth - shareBtnView.bounds.width - likeBtnView.bounds.width - 35, height: 30)
        
        likeBtnView.addSubview(likeBtn)
        shareBtnView.addSubview(shareBtn)
        textView.addSubview(textField)
        
        let likeBarItem = UIBarButtonItem(customView: likeBtnView)
        let shareBarItem = UIBarButtonItem(customView: shareBtnView)
        let textBarItem = UIBarButtonItem(customView: textView)
        let toolBarItems = [likeBarItem, textBarItem, shareBarItem]
        ToolBar.setItems(toolBarItems, animated: true)
        
        let contentText = "Hello! Welcome to my new page!HAHAHAHAHAHAHAHAHAHAH\n<b>This is my home page!\n</b><img>http://img5.duitang.com/uploads/item/201209/10/20120910111702_CNPJj.thumb.700_0.jpeg</img>\nI Love You All!\nLove You!\n<img>http://pic.rmb.bdstatic.com/f54083119edfb83c4cfe9ce2eeebc076.jpeg</img>\n<img>noData</img>\nGOOD!\n<img>http://img3.imgtn.bdimg.com/it/u=1656811409,1242727312&fm=26&gp=0.jpg</img>\n<img>wow</img>\n<img>http://upload.pig66.com/uploadfile/2017/0511/20170511080327163.jpg</img>"
        
        let attributedContent = formatTransfer(labelStr: contentText)
        let strRec = attributedContent.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 20, height: CGFloat(MAXFLOAT)), options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil)
        textHeight = strRec.height + 40
        label.attributedText = attributedContent
        label.frame = CGRect(x: 5, y: kNavBarHeight, width: UIScreen.main.bounds.width - 20, height: textHeight)
        ScrollView.contentSize = CGSize(width: kWidth, height: textHeight + replyView.frame.height + kNavBarHeight + 105 + CGFloat(isXHeight))
        self.ScrollView.addSubview(label)
        self.ScrollView.addSubview(replyView)
        self.view.addSubview(ScrollView)
        self.view.addSubview(ToolBar)
        //countReply = 0.0
        //ScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: height + replyView.frame.height)
        // Do any additional setup after loading the view.
    }
    
    lazy var replyView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.estimatedItemSize = CGSize(width: kWidth, height: 180)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.headerReferenceSize = CGSize(width: kWidth, height: 40)
        layout.sectionHeadersPinToVisibleBounds = true
        
        let tabbarSpace: CGFloat = (self.tabBarController?.tabBar.frame.height)!
        
        let contentView = UICollectionView.init(frame: CGRect.init(x: 0.0, y: kNavBarHeight + label.frame.height, width: kWidth, height: kHeight - kNavBarHeight - 40 - CGFloat(isXHeight)), collectionViewLayout: layout)
        contentView.dataSource = self
        contentView.delegate = self
        contentView.register(ReplyCell.self, forCellWithReuseIdentifier: "ReplyCell")
        contentView.register(ReplyHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ReplyHeader")
        contentView.backgroundColor = UIColor.white
        //contentView.isScrollEnabled = false
        
        return contentView
    }()
    
    @objc func clickCityTextfield(){
        textField.resignFirstResponder()
        popview.showInWindow()
    }
    
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
    
    func numberOfSections(in replyView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ replyView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ replyView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = replyView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ReplyHeader", for: indexPath) as! ReplyHeaderCell
        headerView.label.text = "Reply"
        return headerView
    }
    
    func collectionView(_ replyView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = replyView.dequeueReusableCell(withReuseIdentifier: "ReplyCell", for: indexPath) as! ReplyCell
        let i = indexPath.item
        cell.userLabel.text = "User" + String(i)
        cell.replyContent.text = data[i]
        let strRec = cell.replyContent.text.boundingRect(with: CGSize(width: cell.frame.width - 30, height: 1000000), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: cell.replyContent.font ?? UIFont.systemFont(ofSize: 15)], context: nil)
        let height = strRec.height
        cell.replyContent.frame.size.height = height + 30
        return cell
    }
    
    /*func collectionView(_ contentView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false;
    }*/
}

extension ArticleViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.clickCityTextfield()
        return false
    }
}

