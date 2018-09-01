//
//  NameCell.swift
//  Stuffy
//
//  Created by Hayden Murdock on 7/27/18.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var itemQuantityTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    func updateNameCell(with item: Item?, with category: Category?) {
        guard let item = item, let category = category else { return }
        self.backgroundColor = Colors.stuffyBackgroundGray
    
        itemNameTextField.text = item.name
        
        itemPriceTextField.text = "\(item.price)"
        itemQuantityTextField.text = "\(item.quantity)"
        
        categoryLabel.text = category.name
    }
    
}
