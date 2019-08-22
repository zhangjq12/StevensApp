//
//  RecommendFilterViewController.swift
//  stevens
//
//  Created by Shuhao Bai on 8/5/19.
//  Copyright © 2019 JqZhang. All rights reserved.
//  code参考：https://www.youtube.com/watch?v=22zu-OTS-3M
//

import UIKit

// MARK: - IBActions
// https://www.raywenderlich.com/462-storyboards-tutorial-for-ios-part-2

// https://www.youtube.com/watch?v=Ps8bmxYdIVI

/*
class RecommendFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblDropDown: UITableView!
    @IBOutlet weak var tblDropDownHC: NSLayoutConstraint!
    var btnFilterSelection = UIButton?()
    
    var isTableVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblDropDown.delegate = self
        tblDropDown.dataSource = self
        tblDropDownHC.constant = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "filter")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "filter")
        }
        cell?.textLabel?.text = "\(indexPath.row + 1) rooms"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        btnFilterSelection.setTitle("Recommend Filter: \(indexPath.row + 1)", for: .normal)
        
        UIView.animate(withDuration: 0.5) {
            self.tblDropDownHC.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func selectFilter(_ sender : AnyObject) {
        
        UIView.animate(withDuration: 0.5){
            if self.isTableVisible == false {
                self.isTableVisible = true
                self.tblDropDownHC.constant = 44.0 * 3.0
            } else {
                self.tblDropDownHC.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
}

*/

//==== 这一大块代码是drop-down menu
extension CategoryViewController {
 
 @IBAction func cancelRecommendFilterViewController(_ segue: UIStoryboardSegue) {
 }
 
 @IBAction func saveRecommendFilter(_ segue: UIStoryboardSegue) {
 }
}
 
class RecommendFilterViewController: UIViewController {

    var button = dropDownBtn()

    override func viewDidLoad() {
        super.viewDidLoad()
        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Filter Options", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(button)
        //view.addSubview(button)


        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        button.widthAnchor.constraint(equalToConstant: 150).isActive = true // button width
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true // button height

        button.dropView.dropDownOptions = ["Most Recent Posts", "Most Viewed Posts"]
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//===============Protocol==================
//这个protocal就是passing data，对用户在下拉菜单中的选择做出数据处理，比如这个例子就是把在下拉菜单中选中的选项显示在这个下拉菜单的title中
protocol dropDownProtocal {
    func dropDownPressed(string : String)
}

//========Drop-down-menu=======
class dropDownBtn: UIButton, dropDownProtocal{
    func dropDownPressed(string: String) {  //这个方程就是把dropdown menu中用户选择的选项设定为title
        self.setTitle(string, for: .normal)
        self.dismissDropDown() // 调用dismissDropDown方程，在选择完选项后关闭下拉菜单
    }


    var dropView = dropDownView()
    var height = NSLayoutConstraint()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.darkGray

        dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self //because of this line of code, the options that got choosen - the data - will be passed along to the func dropDownPressed
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }

    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }

    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])

            //消除drop down menu里空白的row
            if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant = 150
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }

            //self.height.constant = 150


            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
                }, completion: nil)


        } else {
            isOpen = false

            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
        }
    }
    func dismissDropDown(){//选完选项之后关闭下拉菜单

        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource {

    var dropDownOptions = [String]()

    var tableView = UITableView()

    var delegate : dropDownProtocal! //create a delegate part for our drop down view

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.backgroundColor = UIColor.darkGray
        self.backgroundColor = UIColor.darkGray

        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(tableView)

        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}



