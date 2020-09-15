//
//  BuyBookViewController.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import UIKit

class BuyBookViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [Link]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BuyBookViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "linkCell", for: indexPath) as! BuyBookViewCell
        cell.configureCell(self.data?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var top: CGFloat = 10
        var left: CGFloat = 40
        var bottom: CGFloat = 10
        var right: CGFloat = 40

        if UIDevice.current.userInterfaceIdiom == .pad {
            top = 10
            left = 40
            bottom = 10
            right = 40
        }
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        var minimumSpace: CGFloat = 15
        if UIDevice.current.userInterfaceIdiom == .pad {
            minimumSpace = 20
        }
        return minimumSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var collectionCellWidth = (collectionView.frame.size.width)/3.5
        var collectionCellHeight = (collectionView.frame.size.width)/2.2
        if UIDevice.current.userInterfaceIdiom == .pad {
            collectionCellWidth = (collectionView.frame.size.width - 60)/4
            collectionCellHeight = (collectionView.frame.size.width)/3
        }
        
        return CGSize(width: collectionCellWidth, height: collectionCellHeight)
    }
}
