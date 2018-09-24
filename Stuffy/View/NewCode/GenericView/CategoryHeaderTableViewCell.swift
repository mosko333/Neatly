//
//  CategoryHeaderTableViewCell.swift
//  Stuffy
//
//  Created by Adam on 22/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class CategoryHeaderTableViewCell: UITableViewCell {
    
    struct Constants {
        static let shadowRadius: CGFloat = 4.0
        static let grayRatio: CGFloat = 200/255
        static let shadowOffset = CGSize(width: 0, height: 5)
        static let shadowOpacity: Float = 0.5
    }
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var shadowView: UIView!
    //
    // MARK: - Methods
    //
    func addShadow() {
        shadowView.layer.shadowColor = UIColor(red: Constants.grayRatio, green: Constants.grayRatio, blue: Constants.grayRatio, alpha: 1).cgColor
        shadowView.layer.shadowRadius = Constants.shadowRadius
        shadowView.layer.shadowOffset = Constants.shadowOffset
        shadowView.layer.shadowOpacity = Constants.shadowOpacity
    }

}
