//
//  myStuffViewController.swift
//  Stuffy
//
//  Created by Adam Moskovich on 9/18/18.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

class MyStuffViewController: UIViewController {
    //
    // MARK: - Properties
    //
    var category: Category?
    var items: [Item] = []
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyItemView: UIView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = category?.name
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        //        self.tableView.contentInset = insets
        unpackItems()
        setupView()
        tableView.reloadData()
    }
    
    //    override func viewDidDisappear(_ animated: Bool) {
    //        super.viewDidDisappear(true)
    //        navigationController?.popViewController(animated: true)
    //    }
    
    //
    // MARK: - Methods
    //
    func setupView() {
        if items.count == 0 {
            emptyItemView.isHidden = false
        } else {
            emptyItemView.isHidden = true
        }
    }
    func unpackItems() {
        guard let elements = category?.items else { return }
        var unpackedItems: [Item] = []
        for element in elements {
            if let item = element as? Item {
                unpackedItems.append(item)
            }
        }
        self.items = unpackedItems
        print(items.count)
    }
    //
    // MARK: - Actions
    //
    @IBAction func backBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editBtnTapped(_ sender: UIBarButtonItem) {
        print("add item button pressed")
    }
    //
    // MARK: - Navigation
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemSummery" {
            guard let destinationVC = segue.destination as? UINavigationController,
                let indexPath = tableView.indexPathForSelectedRow,
                let topVC = destinationVC.topViewController as? AddItemTableViewController  else { return }
            let item = items[indexPath.row]
            topVC.isItemSummery = true
            topVC.showCameraCell = false
            topVC.item = item
        }
    }
}
//
// MARK: - Extensions
//
extension MyStuffViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myStuffCell", for: indexPath) as? SummaryWithImageTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        let item = items[indexPath.row]
        cell.updateCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            
            self.presentDeleteAlertController(indexPathRow: indexPath.row)
        }
        deleteAction.backgroundColor = Colors.stuffyRed
        
        //return [editAction,deleteAction]
        return [deleteAction]
    }
}
// Alert Controller
extension MyStuffViewController {
    func presentDeleteAlertController(indexPathRow: Int) {
        let alertController = UIAlertController(title: "Are you sure you want to delete this Item?", message: "", preferredStyle: .alert)
        // - Add Actions
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            // AKA What happens when we press the button
            let item = self.items[indexPathRow]
            
            
            CoreDataController.shared.deleteItem(with: item)
            
            
            
            self.items.remove(at: indexPathRow)
            
            self.tableView.reloadData()
            
        }
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // - Add actions to alert controller
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        // - Present Alert Controller
        present(alertController, animated: true)
    }
}
extension MyStuffViewController: SummaryWithImageTableViewCellDelegate {
    func itemFavorited(_ cell: SummaryWithImageTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = items[indexPath.row]
        item.isFavorite = !item.isFavorite
        print(item.isFavorite)
        CoreDataStack.save()
    }
}
