//
//  BestSellersListPresenter.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import Foundation

class BestSellersListPresenter {
    
    var data: [List] = [List]()
    var view: BestSellersListViewController?
    
    init(view: BestSellersListViewController) {
        self.view = view
    }
    
    func getData() {
        self.view?.loaderAnimationStart()
        DispatchQueue.global(qos: .userInitiated).async {
            APIService.shared.getLists { (lists, success, error) in
                self.view?.loaderAnimationStop()
                if success, let lists = lists as? [List] {
                    self.data = lists
                    DispatchQueue.main.async {
                        self.view?.refreshView()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view?.showAlert(message: error ?? "")
                    }
                }
            }
        }
    }
}
