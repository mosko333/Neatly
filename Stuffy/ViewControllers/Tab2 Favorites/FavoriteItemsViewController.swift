//
//  FavoriteItemsViewController.swift
//  Stuffy
//
//  Created by Adam Moskovich on 9/22/18.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

class FavoriteItemsViewController: UIViewController {
    //
    // MARK: - Properties
    //
    var favoritedCategories: [Category] = []
    var favoritedItems: [Item] = []
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateView: UIView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchFavorites()
        self.tableView.reloadData()
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
    fileprivate func fetchFavorites() {
        favoritedCategories = CategoryController.shared.sortedCategoriesFavorites
        favoritedItems = ItemController.sortedItemFavorites
        emptyStateView.isHidden = favoritedCategories.count == 0 && favoritedItems.count == 0 ? false : true
    }
    //
    // MARK: - Navigation
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyStuffSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let category =  CategoryController.shared.categories[indexPath.row]
            if let destinationVC = segue.destination as? MyStuffViewController {
                destinationVC.category = category
            }
        }
        
        if segue.identifier == "toItemSummery" {
            guard let destinationVC = segue.destination as? UINavigationController,
                let indexPath = tableView.indexPathForSelectedRow,
                let topVC = destinationVC.topViewController as? AddItemTableViewController  else { return }
            let item = favoritedItems[indexPath.row]
            topVC.isItemSummery = true
            topVC.showCameraCell = false
            topVC.item = item
        }
    }
}
extension FavoriteItemsViewController: UITableViewDataSource, UITableViewDelegate{
    //
    // MARK: - Delegate @ Data Source Methods
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (favoritedCategories.count)
        }
        if section == 1 {
            return (favoritedItems.count)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
            let category = favoritedCategories[indexPath.row]
            cell.updateCell(category)
            cell.delegate = self
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! SummaryWithImageTableViewCell
            let item = favoritedItems[indexPath.row]
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
        return 63
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatHeader") as? CategoryHeaderTableViewCell else { return UITableViewCell() }
            return cell
        }
        if section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemHeader") as? ItemHeaderTableViewCell else { return UITableViewCell() }
            return cell
        }
        return UITableViewCell()
    }
}
extension FavoriteItemsViewController: CategoryTableViewCellDelegate {
    func categoryFavorited(_ cell: CategoryTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let category =  favoritedCategories[indexPath.row]
        category.isFavorite = !category.isFavorite
        CoreDataStack.save()
    }
}
extension FavoriteItemsViewController: SummaryWithImageTableViewCellDelegate {
    func itemFavorited(_ cell: SummaryWithImageTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = favoritedItems[indexPath.row]
        item.isFavorite = !item.isFavorite
        CoreDataStack.save()
    }
}
