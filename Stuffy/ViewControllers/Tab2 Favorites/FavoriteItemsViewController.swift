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
    }
    //
    // MARK: - Navigation
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
            return favoritedCategories.count
        }
        if section == 1 {
            return favoritedItems.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
            let category = favoritedCategories[indexPath.row]
            cell.updateCell(category)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! SummaryWithImageTableViewCell
            let item = favoritedItems[indexPath.row]
            cell.updateCell(with: item)
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
        
        let categoryHeaderView = UIView()
        let label = UILabel()
        label.layer.backgroundColor = Colors.stuffyBackgroundGray.cgColor
        
        label.font = UIFont.init(name: "Avenir-Heavy", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 64).isActive = true
        // TODO: - put in correct constraints
        //label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22).isActive = true
        categoryHeaderView.addSubview(label)
        categoryHeaderView.backgroundColor = Colors.stuffyBackgroundGray
        if section == 0 {
            label.text = "    Categories"
            let lineSeparatorView = UIView()
            categoryHeaderView.addSubview(lineSeparatorView)
            lineSeparatorView.layer.backgroundColor = Colors.stuffyLightGray.cgColor
            lineSeparatorView.translatesAutoresizingMaskIntoConstraints = false
            lineSeparatorView.bottomAnchor.constraint(equalTo: categoryHeaderView.bottomAnchor, constant: 0).isActive = true
            lineSeparatorView.leftAnchor.constraint(equalTo: categoryHeaderView.leftAnchor, constant: 0).isActive = true
            lineSeparatorView.rightAnchor.constraint(equalTo: categoryHeaderView.rightAnchor, constant: 0).isActive = true
            lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            return categoryHeaderView
        }
        if section == 1 {
            label.text = "    Items"
        }
        return categoryHeaderView
    }
}
