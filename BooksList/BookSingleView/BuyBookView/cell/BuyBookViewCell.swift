//
//  BuyBookViewCell.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import UIKit

class BuyBookViewCell: UICollectionViewCell {
    
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var shopLabel: UILabel!
    
    
    func configureCell(_ data: Link?) {
        qrImage.image = data?.url.generateQRCode()
        shopLabel.text = data?.name
    }
    
}
