//
//  SearchViewController.swift
//  Stuffy
//
//  Created by Adam on 22/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    //
    // MARK: - Methods
    //
    var categoryResults: [Category] = []
    var itemResults: [Item] = []
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var cancelBtnWidthConstraint: NSLayoutConstraint!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupTableView()
        hideKeyboard()
        cancelBtnWidthConstraint.constant = 0
    }
    //
    // MARK: - Methods
    //
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.stuffyBackgroundGray
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.tableView.contentInset = insets
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchBar.endEditing(true)
        if let text = searchBar.text,
            text.isEmpty {
            setCancelBtnWidth(isHidden: true)
        }
    }
    
    func setCancelBtnWidth(isHidden: Bool) {
            cancelBtnWidthConstraint.constant = isHidden ? 0 : 93
    }
    
//    fileprivate func fetchSearchResults() {
//        guard let searchTerm = searchBar.text,
//            !searchTerm.isEmpty else { return }
//        categoryResults = CategoryController.shared.searchCategoriesBy(searchTerm: searchTerm)
//        itemResults = ItemController.searchItemsBy(searchTerm: searchTerm)
//        //emptyStateView.isHidden = categoryResults.count == 0 && itemResults.count == 0 ? false : true
//    }
    
    //
    // MARK: - Navigation
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyStuffSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let category =  categoryResults[indexPath.row]
            if let destinationVC = segue.destination as? MyStuffViewController {
                destinationVC.category = category
            }
        }
        
        if segue.identifier == "toItemSummery" {
            guard let destinationVC = segue.destination as? UINavigationController,
                let indexPath = tableView.indexPathForSelectedRow,
                let topVC = destinationVC.topViewController as? AddItemTableViewController  else { return }
            let item = itemResults[indexPath.row]
            topVC.isItemSummery = true
            topVC.showCameraCell = false
            topVC.item = item
        }
    }
    //
    // MARK: - Actions
    //
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        searchBar.text = ""
        searchBar.endEditing(true)
        setCancelBtnWidth(isHidden: true)
    }
}
//
// MARK: - Extensions
//
extension SearchViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        setCancelBtnWidth(isHidden: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        categoryResults = CategoryController.shared.searchCategoriesBy(searchTerm: searchText)
        itemResults = ItemController.searchItemsBy(searchTerm: searchText)
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let text = searchBar.text,
            text.isEmpty {
            setCancelBtnWidth(isHidden: true)
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return categoryResults.count
        }
        if section == 1 {
            return itemResults.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
            let category = categoryResults[indexPath.row]
            cell.updateCell(category)
            cell.delegate = self
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! SummaryWithImageTableViewCell
            let item = itemResults[indexPath.row]
            cell.updateCell(with: item)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 61.0
        } else {
            return 95
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 63
        } else {
            return 77
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatHeader") as? CategoryHeaderTableViewCell else { return UITableViewCell() }
            cell.addShadow()
            return cell
        }
        if section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemHeader") as? ItemHeaderTableViewCell else { return UITableViewCell() }
            return cell
        }
        return UITableViewCell()
    }
}

extension SearchViewController: CategoryTableViewCellDelegate {
    func categoryFavorited(_ cell: CategoryTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let category =  categoryResults[indexPath.row]
        category.isFavorite = !category.isFavorite
        CoreDataStack.save()
    }
}

extension SearchViewController: SummaryWithImageTableViewCellDelegate {
    func itemFavorited(_ cell: SummaryWithImageTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = itemResults[indexPath.row]
        item.isFavorite = !item.isFavorite
        CoreDataStack.save()
    }
}
