//
//  ListCollectionViewCell.swift
//  boostcamp_3_iOS
//
//  Created by 김예은 on 06/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        backView.circleImageView()
    }
    
}
