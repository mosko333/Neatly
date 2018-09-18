//
//  SummeryItemImageCollectionViewCell.swift
//  Stuffy
//
//  Created by Adam on 17/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

protocol SummeryItemImageDelegate: class {
    func deleteImage(cell: SummeryItemImageCollectionViewCell)
    func addPhoto()
    func updateCover(cell: SummeryItemImageCollectionViewCell)
}

class SummeryItemImageCollectionViewCell: UICollectionViewCell {
    //
    // MARK: - Properties
    //
    weak var delegate: SummeryItemImageDelegate?
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var itemImage: UIImageView!
    //
    // MARK: - Actions
    //
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        delegate?.deleteImage(cell: self)
    }
    @IBAction func addPhotoBtnTapped(_ sender: UIButton) {
        delegate?.addPhoto()
    }
    @IBAction func coverBtnTapped(_ sender: UIButton) {
        delegate?.updateCover(cell: self)
    }
}
