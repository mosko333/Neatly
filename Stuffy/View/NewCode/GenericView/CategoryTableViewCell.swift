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
    //
    // MARK: - Outlets
    //
    weak var delegate: CategoryTableViewCellDelegate?
    var isFavorite: Bool = false
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryCountLabel: UILabel!
    @IBOutlet weak var isFavoritedButton: UIButton!
    //
    // MARK: - Methods
    //
    
    func updateCell(_ category: Category) {
        categoryNameLabel.text = category.name
        let itemCount = category.items?.count ?? 0
        categoryCountLabel.text = "(\(itemCount))"
        isFavorite = category.isFavorite
        updateFavoriteStar()
    }
    fileprivate func updateFavoriteStar() {
        if isFavorite {
            isFavoritedButton.setBackgroundImage(#imageLiteral(resourceName: "xcaCatFavStarFull"), for: .normal)
        } else {
            isFavoritedButton.setBackgroundImage(#imageLiteral(resourceName: "xcaCatFavStarEmpty"), for: .normal)
        }
    }
    //
    // MARK: - Actions
    //
    @IBAction func isFavoritedButtonTapped(_ sender: UIButton) {
        isFavorite = !isFavorite
        updateFavoriteStar()
        delegate?.categoryFavorited(self)
    }
}
