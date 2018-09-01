//
//  HomeScreenCategoryCell.swift
//  Stuffy
//
//  Created by Hayden Murdock on 7/8/18.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

protocol  FavoriteCategoryDelegate: class {
    func categoryFavorited(_ cell: HomeScreenCategoryCell)
}

class HomeScreenCategoryCell: UITableViewCell {

   
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryCountLabel: UILabel!
    @IBOutlet weak var isFavoritedButton: UIButton!
    
    weak var delegate: FavoriteCategoryDelegate?
    
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
