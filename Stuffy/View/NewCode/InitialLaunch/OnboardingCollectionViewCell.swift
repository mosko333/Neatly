//
//  OnboardingCollectionViewCell.swift
//  Stuffy
//
//  Created by Adam on 18/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    struct Constants {
        static let firstOboardingImage = UIImage(named: "xcaOnboardLamp")
        static let secondOboardingImage = UIImage(named: "xcaOnboardPicture")
        static let thirdOboardingImage = UIImage(named: "xcaOnboardAddItem")
    }
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var onboardImage: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var explinationLineOneLable: UILabel!
    @IBOutlet weak var explinationLineTwoLable: UILabel!
    @IBOutlet weak var explinationLineThreeLable: UILabel!
    // Constraints
    @IBOutlet weak var onboardImageAspectConstraint: NSLayoutConstraint!
    @IBOutlet weak var onboardingImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var onboardingImageYConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleSpacingFromImage: NSLayoutConstraint!
    //
    // MARK: - Methods
    //
    func updateCell() {
        if onboardImage.image == Constants.thirdOboardingImage {
            titleLable.text = "ENTER IMPORTANT INFO"
            explinationLineOneLable.text = "Fill in all the details and"
            explinationLineTwoLable.text = "allow yourself to forget them."
            explinationLineThreeLable.text = "We've got it covered."
            onboardImageAspectConstraint.constant = 1
            
            
        } else if onboardImage.image == Constants.secondOboardingImage {

        } else {
            
        }
        
    }
}
