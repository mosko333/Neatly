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
    var tempItem: TempItem?
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
        setupTextFieldDelegates()
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
    
    func setupTextFieldDelegates() {
        itemNameTextField.delegate = self
        priceTextField.delegate = self
        quantityTextField.delegate = self
        storeTextField.delegate = self
        modelNumTextField.delegate = self
        serielNumTextField.delegate = self
    }
    
    func saveToTempItem() {
        tempItem?.name = itemNameTextField.text
        tempItem?.price = priceTextField.text
        tempItem?.quantity = quantityTextField.text
        tempItem?.storePurchasedFrom = storeTextField.text
        tempItem?.modelNumber = modelNumTextField.text
        tempItem?.serialNumber = serielNumTextField.text
        tempItem?.note = notesTextView.text
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
    }
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
    }
    // Select input media
    @IBAction func mediaInputTypeBtnTapped(_ sender: UIButton) {
        //        switch sender.tag {
        //        case 0:
        //            // Library
        //        case 1:
        //            // Camera
        //        case 2:
        //            // Scan
        //        default:
        //            return
        //        }
    }
    // Text field controls
    @IBAction func quantityChangedBtnTapped(_ sender: UIButton) {
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
        if purchaseDateTextField.isFirstResponder {
            purchaseDateTextField.text = "\(datePicker.date)"
            tempItem?.purchaseDate = datePicker.date
        } else if returnDateTextField.isFirstResponder {
            returnDateTextField.text = "\(datePicker.date)"
            tempItem?.returnDate = datePicker.date
        } else if warrantyDateTextField.isFirstResponder {
            warrantyDateTextField.text = "\(datePicker.date)"
            tempItem?.warrantyDate = datePicker.date
        }
    }
    // Delete
    @IBAction func deleteItemBtnTapped(_ sender: UIButton) {
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
}
