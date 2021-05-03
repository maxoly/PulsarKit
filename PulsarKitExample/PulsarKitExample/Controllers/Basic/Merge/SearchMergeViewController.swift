//
//  SearchMergeViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 03/05/21.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

final class SearchMergeViewController: BaseViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    var elements: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Merge"
        view.backgroundColor = .primary
        populate()
        configureSearch()
    }
}

extension SearchMergeViewController {
    func configureSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.textColor = .white
            searchController.searchBar.searchTextField.typingAttributes = [.foregroundColor: UIColor.white]
            searchController.searchBar.searchTextField.defaultTextAttributes = [.foregroundColor: UIColor.white]
            searchController.searchBar.searchTextField.leftView?.tintColor = .white
            searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [.foregroundColor : UIColor.light])
        } else {
            searchController.searchBar.placeholder = "Search..."
        }

        definesPresentationContext = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func populate() {
        let users = (0..<100).map { User(id: $0, name: "Nome: \($0)") }
        elements = users
        source.add(models: users)
    }
}

extension SearchMergeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        let filtered = text.isEmpty ? elements : elements.filter { $0.name.contains(text) }
        source.merge(models: filtered)
        source.update()
    }
}

extension SearchMergeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  
    }
}
