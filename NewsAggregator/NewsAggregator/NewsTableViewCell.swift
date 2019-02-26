
//
//  NewsTableViewCell.swift
//  NewsAggregator
//
//  Created by John Lester Celis on 26/02/2019.
//  Copyright © 2019 John Lester Celis. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
