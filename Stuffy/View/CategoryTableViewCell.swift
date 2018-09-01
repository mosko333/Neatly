//
//  CategoryTableViewCell.swift
//  Stuffy
//
//  Created by Adam on 11/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

protocol  CategoryTableViewCellDelegate: class {
    func categoryFavorited(_ cell: CategoryTableViewCell)
}

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryCountLabel: UILabel!
    @IBOutlet weak var isFavoritedButton: UIButton!
    
    weak var delegate: CategoryTableViewCellDelegate?
    
    var category: Category?
    
    
    func updateCell(_ category: Category) {
        categoryNameLabel.text = category.name
        let itemCount = category.items?.count ?? 0
        categoryCountLabel.text = "(\(itemCount))"
        
        if category.isFavorite == true {
            isFavoritedButton.setBackgroundImage(#imageLiteral(resourceName: "xcaCatFavStarFull"), for: .normal)
        }
        if category.isFavorite == false {
            isFavoritedButton.setBackgroundImage(#imageLiteral(resourceName: "xcaCatFavStarEmpty"), for: .normal)
        }
    }
    
    @IBAction func isFavoritedButtonTapped(_ sender: UIButton) {
        delegate?.categoryFavorited(self)
    }
}
