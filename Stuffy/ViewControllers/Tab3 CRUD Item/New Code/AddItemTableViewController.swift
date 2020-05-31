//
//  AddItemTableViewController.swift
//  Stuffy
//
//  Created by Adam on 06/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    struct Constants {
        static let notePlaceHolderText = "Add Notes"
    }
    //
    // MARK: - Properties
    //
    var isItemSummery = false
    var showCameraCell = true
    var tempItem = TempItem()
    var item: Item?
    let imagePickerController = UIImagePickerController()
    var category: Category {
        return tempItem.category ?? CategoryController.shared.categories[0]
    }
    //
    // MARK: - Outlets
    //
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var rightBarBtnItem: UIBarButtonItem!
    @IBOutlet weak var leftBarBtnItem: UIBarButtonItem!
    @IBOutlet weak var cameraBigBackgroundImageView: UIImageView!
    @IBOutlet weak var cameraSummeryBtn: UIButton!
    @IBOutlet weak var summeryCollectionView: UICollectionView!
    @IBOutlet weak var summeryPageController: UIPageControl!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var purchaseDateTextField: UITextField!
    @IBOutlet weak var returnDateTextField: UITextField!
    @IBOutlet weak var warrantyDateTextField: UITextField!
    @IBOutlet weak var storeTextField: UITextField!
    @IBOutlet weak var modelNumTextField: UITextField!
    @IBOutlet weak var serielNumTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewFromItem()
        setupDateFieldKeyboards()
        hideKeyboard()
        clearTextView()
        setupDelegates()
        setupNavBar()
        //        tempItem.images.append(#imageLiteral(resourceName: "xcaCameraCellDefaultImage"))
        //        tempItem.images.append(#imageLiteral(resourceName: "xcaOnboardLamp"))
        //        tempItem.images.append(#imageLiteral(resourceName: "xcaSampleImage"))
        //        tempItem.images.append(#imageLiteral(resourceName: "xcaSplashScreen"))
        //        tempItem.images.append(#imageLiteral(resourceName: "xcaAddItemBarBtn"))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateImages()
    }
    //
    // MARK: - Methods
    //
    func setupViewFromItem() {
        if let item = item {
            tempItem = TempItem(item: item)
            updateImages()
            setTextFieldsAndViewsFromTempItem()
        }
    }
    func setTextFieldsAndViewsFromTempItem() {
        let dateFormater = DateFormatter()
        catNameLabel.text = tempItem.category?.name
        itemNameTextField.text = tempItem.name
        currencyTextField.text = UserDefaults.standard.object(forKey: CurrencyViewController.Constants.currencyKey) as? String ?? "$"
        priceTextField.text = "\(tempItem.price ?? 0)"
        quantityTextField.text = "\(Int(tempItem.quantity ?? 1))"
        if let purchaseDate = tempItem.purchaseDate {
            dateFormater.dateStyle = .long
            purchaseDateTextField.text = dateFormater.string(from: purchaseDate)
        }
        if let returnDate = tempItem.returnDate {
            dateFormater.dateStyle = .short
            returnDateTextField.text = dateFormater.string(from: returnDate)
        }
        if let warrantyDate = tempItem.warrantyDate {
            dateFormater.dateStyle = .short
            returnDateTextField.text = dateFormater.string(from: warrantyDate)
        }
        storeTextField.text = tempItem.storePurchasedFrom
        modelNumTextField.text = tempItem.modelNumber
        serielNumTextField.text = tempItem.serialNumber
        notesTextView.text = tempItem.note
    }
    func updateImages() {
        if tempItem.images.count > 0 {
            cameraBigBackgroundImageView.image = tempItem.images[0]
            if tempItem.images.count > 1 {
                cameraSummeryBtn.setImage(tempItem.images[1], for: .normal)
            } else {
                cameraSummeryBtn.setImage(tempItem.images[0], for: .normal)
            }
        }
    }
    func setupDateFieldKeyboards() {
        purchaseDateTextField.inputView = datePicker
        returnDateTextField.inputView = datePicker
        warrantyDateTextField.inputView = datePicker
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func clearTextView() {
        notesTextView.delegate = self
        notesTextView.textColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 1)
        notesTextView.text = "Add Notes"
    }
    
    func setupDelegates() {
        summeryCollectionView.delegate = self
        summeryCollectionView.dataSource = self
        imagePickerController.delegate = self
        itemNameTextField.delegate = self
        priceTextField.delegate = self
        quantityTextField.delegate = self
        storeTextField.delegate = self
        modelNumTextField.delegate = self
        serielNumTextField.delegate = self
    }
    
    func setupNavBar() {
        rightBarBtnItem.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if isItemSummery {
            navigationController?.title = "Item Summary"
            leftBarBtnItem.title = "Done"
            rightBarBtnItem.title = ""
            if let isFavorive = tempItem.isFavorite,
                isFavorive == true {
                rightBarBtnItem.image = #imageLiteral(resourceName: "xcaItemSummaryFavStarFull")
                rightBarBtnItem.tintColor = #colorLiteral(red: 0.4784313725, green: 0.7058823529, blue: 0.9921568627, alpha: 1)
            } else {
                rightBarBtnItem.image = #imageLiteral(resourceName: "xcaItemSummaryFavStarEmpty")
            }
        } else {
            navigationController?.title = ""
            leftBarBtnItem.title = "Cancel"
            rightBarBtnItem.image = nil
            rightBarBtnItem.title = "Save"
        }
    }
    
    func saveToTempItem() {
        tempItem.name = itemNameTextField.text
        if let price = priceTextField.text, !price.isEmpty {
            tempItem.price = Double(price)
        }
        if let quantity = quantityTextField.text, !quantity.isEmpty {
            tempItem.quantity = Double(quantity)
        }
        tempItem.storePurchasedFrom = storeTextField.text
        tempItem.modelNumber = modelNumTextField.text
        tempItem.serialNumber = serielNumTextField.text
        tempItem.note = notesTextView.text
        print(tempItem)
    }
    
    func updateItemFromTempCard() {
        saveToTempItem()
        if let item = item {
            ItemController.updateFromTempItem(category: category, item: item, tempItem: tempItem)
        }
    }
    
    fileprivate func saveTempCardToCoreData() {
        saveToTempItem()
        if let name = tempItem.name,
            !name.components(separatedBy: .whitespaces).isEmpty,
            let quantaty = quantityTextField.text,
            let quantatyNum = Int(quantaty),
            quantatyNum > 0 {
            ItemController.createItemFrom(category: category, tempItem: tempItem)
            dismiss(animated: true)
        }
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if showCameraCell {
                return 373
            }
            return 0
        }
        if indexPath.row == 1 {
            if showCameraCell {
                return 0
            }
            return 352
        }
        if indexPath.row == 2 {
            if showCameraCell {
                return 0
            }
            return 28
        }
        if indexPath.row == 3 {
            if showCameraCell {
                return 63
            }
            return 0
        }
        if indexPath.row == 4 {
            return 48
        }
        if indexPath.row == 5 {
            return 193
        }
        if indexPath.row == 6 {
            return 59
        }
        if indexPath.row == 7 {
            return 490
        }
        if indexPath.row == 8 {
            return 284
        }
        //        if indexPath.row == 7 {
        //            return 0
        //        }
        return 0
    }
    
    //
    // MARK: - Actions
    //
    // Bar Button Items
    @IBAction func leftBarBtnTapped(_ sender: UIBarButtonItem) {
        if isItemSummery {
            updateItemFromTempCard()
        }
        dismiss(animated: true)
    }
    // btn for 'Save' if addItemVC or 'isFavorite' if itemSummeryVC
    @IBAction func rightBarBtnTapped(_ sender: UIBarButtonItem) {
        if isItemSummery {
            if let isFavorite = tempItem.isFavorite {
                if isFavorite {
                    tempItem.isFavorite = false
                    rightBarBtnItem.image = #imageLiteral(resourceName: "xcaItemSummaryFavStarEmpty")
                    rightBarBtnItem.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    tempItem.isFavorite = true
                    rightBarBtnItem.image = #imageLiteral(resourceName: "xcaItemSummaryFavStarFull")
                    rightBarBtnItem.tintColor = #colorLiteral(red: 0.4784313725, green: 0.7058823529, blue: 0.9921568627, alpha: 1)
                }
                if let item = item {
                    ItemController.update(category: category, item: item, isFavorite: tempItem.isFavorite)
                }
            }
        } else {
            saveTempCardToCoreData()
            dismiss(animated: true)
        }
    }
    // Select input media
    @IBAction func mediaInputTypeBtnTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            pickImageFromLibrary()
        case 1:
            pickImageWithCamera()
        case 2:
            // Scan
            performSegue(withIdentifier: "toNavControllerAutoCrop", sender: self)
        default:
            return
        }
    }
    // Text field controls
    @IBAction func quantityChangedBtnTapped(_ sender: UIButton) {
        guard let quantityLabel = quantityTextField.text,
            var quantity = Int(quantityLabel) else { return }
        switch sender.tag {
        case 0:
            if quantity > 1 {
                quantity -= 1
            }
        case 1:
            if quantity < 10000 {
                quantity += 1
            }
        default:
            return
        }
        tempItem.quantity = Double(quantity)
        quantityTextField.text = "\(quantity)"
    }
    @IBAction func dateBtnPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            purchaseDateTextField.becomeFirstResponder()
        case 1:
            returnDateTextField.becomeFirstResponder()
        case 2:
            warrantyDateTextField.becomeFirstResponder()
        default:
            return
        }
    }
    @IBAction func datePickerSelected(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        if purchaseDateTextField.isFirstResponder {
            dateFormater.dateStyle = .long
            purchaseDateTextField.text = dateFormater.string(from: datePicker.date)
            tempItem.purchaseDate = datePicker.date
        } else if returnDateTextField.isFirstResponder {
            dateFormater.dateStyle = .short
            returnDateTextField.text = dateFormater.string(from: datePicker.date)
            tempItem.returnDate = datePicker.date
        } else if warrantyDateTextField.isFirstResponder {
            dateFormater.dateStyle = .short
            warrantyDateTextField.text = dateFormater.string(from: datePicker.date)
            tempItem.warrantyDate = datePicker.date
        }
    }
    // Delete
    @IBAction func deleteItemBtnTapped(_ sender: UIButton) {
        if let item = item,
            let category = item.category {
            ItemController.delete(item: item, fromA: category)
        }
        dismiss(animated: true)
    }
    @IBAction func unwindToAddItemTVC(_ sender: UIStoryboardSegue) { }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFullScreenImageVC",
            let destinationVC = segue.destination as? FullScreenImageViewController {
            destinationVC.tempItem = tempItem
        }
        if segue.identifier == "toSelectCatVC",
            let destinationVC = segue.destination as? CategoriesViewController {
            destinationVC.delegate = self
            destinationVC.isHomeVC = false
        }
    }
}

extension AddItemTableViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if notesTextView.text == Constants.notePlaceHolderText {
            notesTextView.text = ""
        }
        notesTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if notesTextView.text == Constants.notePlaceHolderText || notesTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            clearTextView()
            saveToTempItem()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        saveToTempItem()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == quantityTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            return updatedText.count <= 4
        }
        return true
    }
}

//
// MARK: - Extensions
//
extension AddItemTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func pickImageFromLibrary() {
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true)
    }
    func pickImageWithCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true)
        } else {
            print("Camera not available")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        tempItem.images.append(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}

extension AddItemTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numOfPages = max(tempItem.images.count, 1)
        summeryPageController.numberOfPages = numOfPages
        return numOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summeryCell", for: indexPath) as! SummeryItemImageCollectionViewCell
        cell.itemImage.image = tempItem.images.isEmpty ? UIImage(named: "xcaCameraCellDefaultImage") : tempItem.images[indexPath.row]
        cell.delegate = self
        return cell
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        
        summeryPageController.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}

extension AddItemTableViewController: SummeryItemImageDelegate {
    func deleteImage(cell: SummeryItemImageCollectionViewCell) {
        if let indexPath = summeryCollectionView.indexPath(for: cell),
            let item = item,
            let image = item.images?[indexPath.row] as? Image {
            ImageController.delete(image: image, fromA: item)
            tempItem.images.remove(at: indexPath.row)
            summeryCollectionView.deleteItems(at: [indexPath])
        }
    }
    
    func addPhoto() {
        showCameraCell = true
        setupNavBar()
        tableView.reloadData()
    }
    
    func updateCover(cell: SummeryItemImageCollectionViewCell) {
        if let indexPath = summeryCollectionView.indexPath(for: cell) {
            let image = cell.itemImage.image
            summeryCollectionView.moveItem(at: indexPath, to: IndexPath(row: 0, section: 0))
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.summeryCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }) { (Success) in
                self.tempItem.images.remove(at: indexPath.row)
                self.tempItem.images.insert(image, at: 0)
                self.summeryCollectionView.reloadData()
            }
        }
    }
}

extension AddItemTableViewController: CatergorieSelectedDelegate {
    func selected(category: Category) {
        tempItem.category = category
        catNameLabel.text = category.name
    }
}

