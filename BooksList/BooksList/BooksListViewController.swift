//
//  BooksListViewController.swift
//  BooksList
//
//  Created by NB MacBook on 9/12/20.
//  Copyright © 2020 NB MacBook. All rights reserved.
//

import UIKit

class BooksListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var tableData: [Book]?
    var filteredData: [Book]? = []
    
    var searchController: UISearchController!
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    var byRank: Bool = true
    var byTitle: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
    }
    
    @IBAction func sortButtonAction(_ sender: Any) {
        if byRank {
            self.tableData?.sort {
                $0.title < $1.title
            }
            byRank = false
            byTitle = true
            self.sortButton.setTitle("BY TITLE", for: .normal)
        } else if byTitle {
            self.tableData?.sort {
                $0.author < $1.author
            }
            byTitle = false
            self.sortButton.setTitle("BY AUTHOR", for: .normal)
        } else {
            self.tableData?.sort {
                $0.rank < $1.rank
            }
            byRank = true
            self.sortButton.setTitle("BY RANK", for: .normal)
        }
        tableView.reloadData()
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        self.tableView.tableHeaderView = (self.tableView.tableHeaderView == nil) ? searchController.searchBar : nil
        _ = (searchController.searchBar.isFirstResponder) ? searchController.searchBar.resignFirstResponder() : searchController.searchBar.becomeFirstResponder()
    }
    
    func setSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "search"
        searchController.searchBar.showsBookmarkButton = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.backgroundColor = UIColor(named: "navBarColor")
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.showsCancelButton = false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    func filterDataWithSearchText(_ searchText: String) {
        filteredData = tableData?.filter { $0.title.lowercased().contains(searchText.lowercased())}
        tableView.reloadData()
    }
}

extension BooksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return self.filteredData?.count ?? 0
        }
        return self.tableData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BooksListCell
        let book = (isFiltering) ? filteredData?[indexPath.row] : tableData?[indexPath.row]
        cell.configureCell(book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "bookSingleViewController") as! BookSingleViewController
        vc.data = (isFiltering) ? filteredData?[indexPath.row] : tableData?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BooksListViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterDataWithSearchText(searchBar.text!)
    }
}
