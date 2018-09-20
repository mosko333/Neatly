//
//  SummaryWithImageTableViewCell.swift
//  Stuffy
//
//  Created by Adam on 19/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

protocol SummaryWithImageTableViewCellDelegate: class {
    func itemFavorited(_ cell: SummaryWithImageTableViewCell)
}

class SummaryWithImageTableViewCell: UITableViewCell {
    //
    // MARK: - Properties
    //
    weak var delegate: SummaryWithImageTableViewCellDelegate?
    var isFavorite = false
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var datePurchasedLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var isFavoritedButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    //
    // MARK: - Lifecycle Functions
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellShadow()
    }
    //
    // MARK: - Methods
    //
    fileprivate func setupCellShadow() {
        self.shadowView.layer.masksToBounds = false
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOpacity = 0.23
        self.shadowView.layer.shadowRadius = 4
    }
    func updateCell(with item: Item) {
        itemNameLabel.text = item.name
        isFavorite = item.isFavorite
        setIsFavorite()
        setDate(item)
        setImage(item)
    }
    fileprivate func setDate(_ item: Item) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        datePurchasedLabel.text = dateFormatter.string(from: item.purchaseDate ?? Date()).uppercased()
    }
    fileprivate func setImage(_ item: Item) {
        if let elements = item.images,
            let element = elements[0] as? Image {
            itemImageView.image = element.image
        }
    }
    fileprivate func setIsFavorite() {
        if isFavorite {
            isFavoritedButton.setBackgroundImage(#imageLiteral(resourceName: "xcaItemFavStarFull"), for: .normal)
        } else {
            isFavoritedButton.setBackgroundImage(#imageLiteral(resourceName: "xcaItemFavStarEmpty"), for: .normal)
        }
    }
    //
    // MARK: - Actions
    //
    @IBAction func isFavoritedButtonTapped(_ sender: UIButton) {
        isFavorite = !isFavorite
        setIsFavorite()
        delegate?.itemFavorited(self)
    }


}

