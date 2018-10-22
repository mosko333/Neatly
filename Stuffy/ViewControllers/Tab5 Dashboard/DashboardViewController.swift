//
//  DashboardViewController.swift
//  Stuffy
//
//  Created by Adam on 07/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    //    let userFRC:NSFetchedResultsController<User> = {
    //        let request: NSFetchRequest<User> = User.fetchRequest()
    //
    //        let sortDescriptors = NSSortDescriptor(key: "pin", ascending: true)
    //
    //        request.sortDescriptors = [sortDescriptors]
    //
    //        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    //
    //        return controller
    //    }()
    //
    // MARK: - Properties
    //
    var currency: String {
        return UserDefaults.standard.object(forKey: CurrencyViewController.Constants.currencyKey) as? String ?? "$" }
    var totalItemPrice: Double = 0
    var itemsWithUpcomingWarrentyDates: [Item] = []
    var itemsWithUpcomingReturnDates: [Item] = []
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var warrantyTable: UITableView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        populateTableData()
        warrantyTable.reloadData()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //
    // MARK: - Methods
    //
    fileprivate func setupTableView() {
        warrantyTable.delegate = self
        warrantyTable.dataSource = self
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.warrantyTable.contentInset = insets
    }
    
    func updateViews() {
        // Setup status bar to lightContent because it's changed to dark in the searchVC
        // We set the background colors alpha to 0 because otherwise it's translucent
        //        UIApplication.shared.statusBarView?.backgroundColor = UIColor(white: 0, alpha: 0)
        //        UIApplication.shared.statusBarStyle = .lightContent
        
        // Set insets to see the bottom cells of the table
        
        // TODO - Populate Views using search data
        
        //        try? userFRC.performFetch()
        //        let pin = userFRC.fetchedObjects?.first
    }
    private func populateTableData() {
        totalItemPrice = ItemController.getTotalItemPrice()
        itemsWithUpcomingWarrentyDates = ItemController.getUpcommingItemWarrantyDates()
        itemsWithUpcomingReturnDates = ItemController.getUpcommingItemReturnDates()
    }
}
//
// MARK: - Extensions
//
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TotalCell") as? TotalValueTableViewCell else {return UITableViewCell()}
            let currencySymbol = currency.first ?? "$"
            cell.updateCell(currencySymbol: currencySymbol, totalPrice: totalItemPrice, totalCategories: CategoryController.shared.categories.count, totalItems: ItemController.items.count)
            return cell
        }
        if indexPath.row == 1 {
            return tableView.dequeueReusableCell(withIdentifier: "ReturnHeaderCell") as! HeaderTableViewCell
        }
        if indexPath.row == 2 {
            if itemsWithUpcomingReturnDates.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.isHidden = true
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.dateLabel.text = df.string(from: itemsWithUpcomingReturnDates[0].warrantyDate ?? Date())
                cell.nameLabel.text = itemsWithUpcomingReturnDates[0].name
                return cell
            }
        }
        if indexPath.row == 3 {
            if itemsWithUpcomingReturnDates.count > 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.dateLabel.text = df.string(from: itemsWithUpcomingReturnDates[1].warrantyDate ?? Date())
                cell.nameLabel.text = itemsWithUpcomingReturnDates[1].name
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.isHidden = true
                return cell
            }
        }
        if indexPath.row == 4 {
            if itemsWithUpcomingReturnDates.count > 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.dateLabel.text = df.string(from: itemsWithUpcomingReturnDates[2].warrantyDate ?? Date())
                cell.nameLabel.text = itemsWithUpcomingReturnDates[2].name
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.isHidden = true
                return cell
            }
        }
        if indexPath.row == 5 {
            return tableView.dequeueReusableCell(withIdentifier: "WarrantyHeaderCell") as! HeaderTableViewCell
        }
        if indexPath.row == 6 {
            if itemsWithUpcomingWarrentyDates.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.isHidden = true
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.dateLabel.text = df.string(from: itemsWithUpcomingWarrentyDates[0].returnDate ?? Date())
                cell.nameLabel.text = itemsWithUpcomingWarrentyDates[0].name
                return cell
            }
        }
        if indexPath.row == 7 {
            if itemsWithUpcomingWarrentyDates.count > 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.dateLabel.text = df.string(from: itemsWithUpcomingWarrentyDates[1].returnDate ?? Date())
                cell.nameLabel.text = itemsWithUpcomingWarrentyDates[1].name
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.isHidden = true
                return cell
            }
        }
        if indexPath.row == 8 {
            if itemsWithUpcomingWarrentyDates.count > 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.dateLabel.text = df.string(from: itemsWithUpcomingWarrentyDates[2].returnDate ?? Date())
                cell.nameLabel.text = itemsWithUpcomingWarrentyDates[2].name
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReturnCell") as! ReturnAndWarrantyTableViewCell
                cell.isHidden = true
                return cell
            }
        }else { return UITableViewCell()}
    }
    
}

