//
//  NewsCell.swift
//  stevens
//
//  Created by 张家骞 on 7/14/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {

    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: frame.width - 105, height: 100))
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var hotLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        image.downloadedFrom(imageurl: "http://img5.duitang.com/uploads/item/201209/10/20120910111702_CNPJj.thumb.700_0.jpeg")
        self.addSubview(label)
    }

}
extension UIImageView{
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
}
