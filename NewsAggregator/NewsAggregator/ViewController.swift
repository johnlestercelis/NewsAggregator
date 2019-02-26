//
//  ViewController.swift
//  NewsAggregator
//
//  Created by John Lester Celis on 26/02/2019.
//  Copyright © 2019 John Lester Celis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var arrRes = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        tableView.estimatedRowHeight = 160
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        apiCall()
    }

    func apiCall() {
        let apiKey = "22e33c20e0af420a93af1854fb43d9a2"
        Alamofire.request("https://newsapi.org/v2/top-headlines?sources=bleacher-report&apiKey=\(apiKey)").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["articles"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                
                if self.arrRes.count > 0 {
                    self.tableView.reloadData()
                }
            }
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        if arrRes.count != 0 && indexPath.row <= 2 {
            var dict = arrRes[indexPath.row]
            cell.titleLabel?.text = dict["title"] as? String
            cell.summaryLabel?.text = dict["description"] as? String
            cell.imgView?.load(url: URL(string: (dict["urlToImage"] as? String)!)!)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
