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
    var tempItem = TempItem()
    var item: Item?
    let imagePickerController = UIImagePickerController()
    //
    // MARK: - Outlets
    //
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var cameraBigBackgroundImageView: UIImageView!
    @IBOutlet weak var cameraSummeryBtn: UIButton!
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
        setupDateFieldKeyboards()
        hideKeyboard()
        clearTextView()
        setupDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateImages()
    }
    //
    // MARK: - Methods
    //
    func updateImages() {
        if tempItem.images.count > 0 {
            cameraBigBackgroundImageView.image = tempItem.images[0]
        }
        if tempItem.images.count > 1 {
            cameraSummeryBtn.setImage(tempItem.images[1], for: .normal)
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
        imagePickerController.delegate = self
        itemNameTextField.delegate = self
        priceTextField.delegate = self
        quantityTextField.delegate = self
        storeTextField.delegate = self
        modelNumTextField.delegate = self
        serielNumTextField.delegate = self
    }
    
    func saveToTempItem() {
        tempItem.name = itemNameTextField.text
        tempItem.price = priceTextField.text
        if let quantity = quantityTextField.text, !quantity.isEmpty {
            tempItem.quantity = Double(quantity)
        }
        tempItem.storePurchasedFrom = storeTextField.text
        tempItem.modelNumber = modelNumTextField.text
        tempItem.serialNumber = serielNumTextField.text
        tempItem.note = notesTextView.text
        print(tempItem)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    //
    // MARK: - Actions
    //
    // Bar Button Items
    @IBAction func cancelBtnTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
        if let _ = tempItem.category,
            let name = tempItem.name,
            !name.components(separatedBy: .whitespaces).isEmpty,
            let quantaty = quantityTextField.text,
            let quantatyNum = Int(quantaty),
            quantatyNum > 1 {
            ItemController.createItemFrom(tempItem: tempItem)
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
                    navigationController?.performSegue(withIdentifier: "toNavControllerAutoCrop", sender: self)
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
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        tempItem.images.append(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
