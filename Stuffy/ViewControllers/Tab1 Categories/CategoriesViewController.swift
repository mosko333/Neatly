//
//  CategoriesViewController.swift
//  Stuffy
//
//  Created by Adam Moskovich on 7/2/17.
//  Copyright © 2017 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController {
    //
    // MARK: - Properties
    //
    // This view can be used as the homeVC or as to select a catagory from AddItemVC
    var isHomeVC = true
//    var categoryPicked: Category? {
//        didSet {
//            guard let catName = categoryPicked?.name else { return }
//            print("category picked \(catName)")
//        }
//    }
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCategoryView: UIView!
    @IBOutlet weak var addCatBtn: UIButton!
    // Constraints
    @IBOutlet weak var addCatViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addCatBtnHightConstraint: NSLayoutConstraint!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        setupView()
    }
    //
    // MARK: - Methods
    //
    func setupView() {
        // Setup status bar to lightContent because it's changed to dark in the searchVC
        // We set the background colors alpha to 0 because otherwise it's translucent
        
        if CategoryController.shared.categories.count == 1 {
            emptyCategoryView.isHidden = false
        } else {
            emptyCategoryView.isHidden = true
        }
        
        //        UIApplication.shared.statusBarView?.backgroundColor = UIColor(displayP3Red: 30, green: 57, blue: 81, alpha: 0)
        //        UIApplication.shared.statusBarStyle = .lightContent
        
        // Set insets to see the bottom cells of the table
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.tableView.contentInset = insets
        
        // Set logo on Nav Bar
        if isHomeVC {
            let logo = UIImageView(image: #imageLiteral(resourceName: "xcaBannerNeatly"))
            logo.contentMode = .scaleAspectFit // set imageview's content mode
            self.navigationItem.titleView = logo
            addCatViewHightConstraint.constant = 61
            addCatBtnHightConstraint.constant = 0
            addCatBtn.isHidden = true
        } else {
            addCatViewHightConstraint.constant = 0
            addCatBtnHightConstraint.constant = 66
            addCatBtn.titleLabel?.alpha = 1
            addCatBtn.isHidden = false
        }
        
        // Changing text color of catergory lable text so the "+" is blue and the "Add a Category" is gray
        let placeHolderText = "+  Add a Category"
        let attributedText = NSMutableAttributedString(string: placeHolderText)
        
        attributedText.addAttributes([NSAttributedStringKey.foregroundColor: Colors.stuffyRoyalBlue, NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 16)!], range: getRangeOfSubString(subString: "+", fromString: placeHolderText)) // Blue color attribute
        
        attributedText.addAttributes([NSAttributedStringKey.foregroundColor: Colors.stuffyDarkGray, NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 16)!], range: getRangeOfSubString(subString: "Add a Category", fromString: placeHolderText)) // Dark Gray color attribute
        
        categoryTextField.attributedText = attributedText
    }
    
    func getRangeOfSubString(subString: String, fromString: String) -> NSRange {
        let sampleLinkRange = fromString.range(of: subString)!
        let startPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.lowerBound)
        let endPos = fromString.distance(from: fromString.startIndex, to: sampleLinkRange.upperBound)
        let linkRange = NSMakeRange(startPos, endPos - startPos)
        return linkRange
    }
    
    //
    // MARK: - Navigation
    //
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "MyStuffSegue" {
    //
    //            guard let indexPath = tableView.indexPathForSelectedRow else { return }
    //
    //            let categorypicked =  CategoryController.shared.categories[indexPath.row]
    //            if let destinationVC = segue.destination as? MyStuffViewController {
    //                destinationVC.categoryPicked = categorypicked
    //            }
    //        }
    //    }
    
    
    //
    // MARK: - Actions
    //
    @IBAction func addCatBtnTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.addCatViewHightConstraint.constant = 61
            self.addCatBtnHightConstraint.constant = 0
            self.addCatBtn.titleLabel?.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: {(_) in
            self.addCatBtn.isHidden = true
            self.categoryTextField.becomeFirstResponder()
        })
    }
}

//
// MARK: - Extensions
//
extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    //TABLEVIEW DATA SOURCE FUNCTIONS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryController.shared.categories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        cell.delegate = self
        let category = CategoryController.shared.categories[indexPath.row]
        cell.updateCell(category)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            
            //self.presentDeleteAlertController(indexPathRow: indexPath.row)
        }
        deleteAction.backgroundColor = Colors.stuffyRed
        
        //return [editAction,deleteAction]
        return [deleteAction]
    }
}
extension CategoriesViewController: CategoryTableViewCellDelegate {
    func categoryFavorited(_ cell: CategoryTableViewCell) {
        
        let indexPath = tableView.indexPath(for: cell)
        
        let category =  CategoryController.shared.categories[(indexPath?.row)!]
        
        category.isFavorite = !category.isFavorite
        
        print(category.isFavorite)
        cell.updateCell(category)
        
        CoreDataStack.save()
    }
}

//extension CategoriesViewController {
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
//    }
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .delete:
//            tableView.deleteRows(at: [indexPath!], with: .automatic)
//
//        case .move:
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
//
//        case .update:
//            tableView.reloadRows(at: [indexPath!], with: .automatic)
//
//        case .insert:
//            tableView.insertRows(at: [newIndexPath!], with: .automatic)
//        }
//    }
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//
//        let indexSet = IndexSet(integer: sectionIndex)
//        switch type{
//        case .insert:
//            tableView.insertSections(indexSet, with: .automatic)
//
//        case .delete:
//            tableView.deleteSections(indexSet, with: .automatic)
//
//        default:
//            return
//        }
//    }}







extension CategoriesViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = .black
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == categoryTextField {
            if textField.text == "" {
                setupView()
            }
        }
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let categoryName = categoryTextField.text, categoryName.count > 0{
            
            CategoryController.shared.create(categoryName: categoryName)
            
            tableView.reloadData()
            
            categoryTextField.text = ""
        }
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Create and Present AlertController
//extension CategoriesViewController {
//    func presentDeleteAlertController(indexPathRow: Int) {
//        let alertController = UIAlertController(title: "Are you sure you want to delete this category?", message: "", preferredStyle: .alert)
//        // - Add Actions
//        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
//            // AKA What happens when we press the button
//            
//            let categoryToDelete = CategoryController.shared.categories[indexPathRow]
//            CoreDataController.shared.deleteCategory(with: categoryToDelete)
//            CoreDataController.shared.allCategories.remove(at: indexPathRow)
//            self.tableView.reloadData()
//            
//        }
//        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        // - Add actions to alert controller
//        alertController.addAction(deleteAction)
//        alertController.addAction(cancelAction)
//        // - Present Alert Controller
//        present(alertController, animated: true)
//    }
//}
