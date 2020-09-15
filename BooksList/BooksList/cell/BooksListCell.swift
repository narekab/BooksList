//
//  BooksListCell.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import UIKit
import Kingfisher

class BooksListCell: UITableViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    
    func configureCell(_ data: Book?) {
        bookImage.kf.setImage(with: URL(string: data?.image ?? ""))
        titleLabel.text = data?.title
        authorLabel.text = data?.author
        rankLabel.text = "\(data?.rank ?? 0)"
    }
    
}
