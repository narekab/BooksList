//
//  BestSellersListViewController.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import UIKit

class BestSellersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var presenter: BestSellersListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = BestSellersListPresenter(view: self)
        self.presenter.getData()
    }
    
    func refreshView() {
        self.tableView.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (alertAction) -> Void in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.presenter.getData()
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loaderAnimationStart() {
        self.indicator.startAnimating()
    }
    
    func loaderAnimationStop() {
        self.indicator.stopAnimating()
    }
}

extension BestSellersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! BestSellersListCell
        cell.configureCell(self.presenter.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "booksListViewController") as! BooksListViewController
        vc.tableData = self.presenter.data[indexPath.row].books
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
