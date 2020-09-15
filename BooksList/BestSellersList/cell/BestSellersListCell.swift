//
//  BestSellersListCell.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import UIKit
import Kingfisher

class BestSellersListCell: UITableViewCell {
    
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var oldDateLabel: UILabel!
    @IBOutlet weak var newDateLabel: UILabel!
    @IBOutlet weak var frequencyButton: UIButton!
    
    
    func configureCell(_ data: List) {
        listImage.kf.setImage(with: URL(string: data.image ?? ""))
        listTitleLabel.text = data.name
//        oldDateLabel.text = data.oldDate
//        newDateLabel.text = data.newDate
        frequencyButton.setTitle(data.updated, for: .normal)
    }
}
